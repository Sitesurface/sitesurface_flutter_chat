// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../sitesurface_flutter_chat.dart';
import '../controllers/chat_controller.dart';
import '../utils/debouncer.dart';
import '../utils/locale/inherited_chat_locale.dart';
import '../utils/theme/inherited_chat_theme.dart';

class ChatScreen extends StatefulWidget {
  final ChatDelegate delegate;
  const ChatScreen({
    super.key,
    required this.delegate,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _chatController = ChatController.instance;
  late Group group;
  User? user;
  final ScrollController _scrollController = ScrollController();
  QueryDocumentSnapshot<Map<String, dynamic>>? lastDocument;
  final ValueNotifier<List<Message>> messageNotifier =
      ValueNotifier<List<Message>>([]);
  late final StreamSubscription _messageSubscription;
  final ValueNotifier<bool> showGoToBottom = ValueNotifier<bool>(false);
  final textEditingController = TextEditingController();
  final debouncer = Debouncer(seconds: 3);
  User? currentUser;
  bool isTyping = false;

  @override
  void initState() {
    group = widget.delegate.group!;
    _chatController.activeChatScreen = group.id;
    currentUser = User(id: _chatController.userId ?? '');
    _chatController.currentUser().then((value) {
      currentUser = value;
    });
    getMessages();
    _addListeners();
    super.initState();
  }

  void getMessages() async {
    final data =
        await _chatController.getInitialMessages(group.id, lastDocument);
    if (data.docs.isNotEmpty) {
      lastDocument = data.docs.last;
      final tempMessageList = <Message>[];
      for (var messageSnapshot in data.docs) {
        tempMessageList.add(Message.fromJson(messageSnapshot.data()));
      }
      // TODO : Check if this assignment is expensive and fix it if it is
      messageNotifier.value =
          {...messageNotifier.value, ...tempMessageList}.toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    if (!group.users.contains(_chatController.userId)) {
      return const Scaffold(
        body: Center(
          child: Text('Unauthorized!!! . Kindly restart your app'),
        ),
      );
    }
    return InheritedChatTheme(
      theme: widget.delegate.chatTheme(),
      child: InheritedL10n(
        l10n: widget.delegate.chatL10n(),
        child: Scaffold(
          backgroundColor: widget.delegate.chatTheme().chatBackgroundColor,
          body: Column(
            children: [
              StreamBuilder<DocumentSnapshot<Object?>>(
                stream: _chatController.getGroupUserStream(group),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return widget.delegate
                        .chatAppbarBuilder(context, null, false, group);
                  }
                  try {
                    user = User.fromJson(
                        snapshot.data!.data() as Map<String, dynamic>);
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                  if (user == null) {
                    return widget.delegate
                        .chatAppbarBuilder(context, null, false, group);
                  }
                  final isTyping = group.id == user!.typingGroup;
                  return widget.delegate
                      .chatAppbarBuilder(context, user!, isTyping, group);
                },
              ),
              Expanded(
                child: ValueListenableBuilder<List<Message>>(
                  valueListenable: messageNotifier,
                  builder: (context, value, _) => Stack(
                    children: [
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(10),
                        itemCount: value.length,
                        reverse: true,
                        controller: _scrollController,
                        itemBuilder: (context, index) => widget.delegate
                            .chatMessageBuilder(context, index, value[index],
                                _chatController.userId!, value),
                      ),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: ValueListenableBuilder(
                            valueListenable: showGoToBottom,
                            builder: (context, value, _) {
                              if (value) {
                                return IconButton(
                                    onPressed: () {
                                      _scrollController.jumpTo(0.0);
                                    },
                                    icon: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: brightness == Brightness.dark
                                                ? Colors.grey.withOpacity(0.85)
                                                : Colors.white
                                                    .withOpacity(0.85),
                                            shape: BoxShape.circle),
                                        child: widget.delegate
                                            .chatTheme()
                                            .goToBottomButtonIcon));
                              } else {
                                return const SizedBox();
                              }
                            },
                          ))
                    ],
                  ),
                ),
              ),
              widget.delegate.chatBottomBuilder(
                  textEditingController,
                  _onSendTapped,
                  _onCameraPressed,
                  _onGalleryPressed,
                  _onLocationPressed),
            ],
          ),
        ),
      ),
    );
  }

  void _onSendTapped(String text) async {
    if (user == null) return;
    final currTime = await _chatController.getCurrentTimestamp();
    final message = Message(
        content: text,
        idFrom: _chatController.userId ?? '',
        idTo: _chatController.getRecepientFromGroup(group),
        timestamp: currTime);
    messageNotifier.value = [message, ...messageNotifier.value];
    textEditingController.clear();
    await _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    await _chatController.sendMessage(
        message: message,
        group: group,
        notificationTitle:
            widget.delegate.notificationTitle(group, currentUser!));
    await _chatController.updateTyping(null);
  }

  Future<void> _onCameraPressed() async {
    final navigator = Navigator.of(context);
    final image = await widget.delegate.getCameraImage();
    navigator.pop();
    if (image == null) return;

    // adding local image while the image uploads
    final currTime = await _chatController.getCurrentTimestamp();
    final message = Message(
        type: MessageType.image,
        content: image.path,
        idFrom: _chatController.userId ?? '',
        idTo: _chatController.getRecepientFromGroup(group),
        timestamp: currTime);
    messageNotifier.value = [message, ...messageNotifier.value];
    await _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    final url = await widget.delegate.uploadImage(image);
    if (url == null) return;
    await _chatController.sendMessage(
        message: message.copyWith(content: url),
        group: group,
        notificationTitle:
            widget.delegate.notificationTitle(group, currentUser!));
  }

  Future<void> _onGalleryPressed() async {
    final navigator = Navigator.of(context);
    final image = await widget.delegate.getGalleryImage();
    navigator.pop();
    if (image == null) return;

    // adding local image while the image uploads
    final currTime = await _chatController.getCurrentTimestamp();
    final message = Message(
        type: MessageType.image,
        content: image.path,
        idFrom: _chatController.userId ?? '',
        idTo: _chatController.getRecepientFromGroup(group),
        timestamp: currTime);
    messageNotifier.value = [message, ...messageNotifier.value];
    await _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    final url = await widget.delegate.uploadImage(image);
    if (url == null) return;
    await _chatController.sendMessage(
        message: message.copyWith(content: url),
        group: group,
        notificationTitle:
            widget.delegate.notificationTitle(group, currentUser!));
  }

  Future<void> _onLocationPressed(BuildContext context) async {
    final navigator = Navigator.of(context);
    final latlng = await widget.delegate.getCurrentLocation(context);
    navigator.pop();

    if (latlng == null) return;

    // adding local location
    final currTime = await _chatController.getCurrentTimestamp();
    final message = Message(
        type: MessageType.location,
        content: '${latlng.latitude},${latlng.longitude}',
        idFrom: _chatController.userId ?? '',
        idTo: _chatController.getRecepientFromGroup(group),
        timestamp: currTime);
    messageNotifier.value = [message, ...messageNotifier.value];
    await _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    await _chatController.sendMessage(
        message: message,
        group: group,
        notificationTitle:
            widget.delegate.notificationTitle(group, currentUser!));
  }

  @override
  void dispose() {
    _chatController.activeChatScreen = null;
    _messageSubscription.cancel();
    _scrollController.dispose();
    messageNotifier.dispose();
    textEditingController.dispose();
    debouncer.dispose();
    _chatController.updateTyping(null);
    super.dispose();
  }

  void _addListeners() {
    _messageSubscription =
        _chatController.getNewMessages(group.id).listen((data) {
      try {
        _chatController.resetUnreadMessages(group.id);
        final newMessage = Message.fromJson(data.docs.first.data());
        if (newMessage.idFrom == _chatController.userId) return;
        if (messageNotifier.value.contains(newMessage)) return;
        // TODO Check if this assignment is expensive and fix it if it is
        messageNotifier.value =
            <Message>{newMessage, ...messageNotifier.value}.toList();
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    _scrollController.addListener(() {
      final height = MediaQuery.of(context).size.height;
      if (_scrollController.offset >= height) {
        showGoToBottom.value = true;
      } else {
        showGoToBottom.value = false;
      }
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        getMessages();
      }
    });
    textEditingController.addListener(() {
      if (!isTyping) {
        isTyping = true;
        _chatController.updateTyping(group.id);
      }
      debouncer.run(() {
        isTyping = false;
        _chatController.updateTyping(null);
      });
    });
  }
}
