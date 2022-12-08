part of '../widget/chat_handler_widget.dart';

Future<void> showChat({
  required BuildContext context,
  required ChatDelegate delegate,
  required Group group,
}) {
  delegate.group = group;
  return Navigator.push(context,
      MaterialPageRoute(builder: (context) => _ChatScreen(delegate: delegate)));
}

class _ChatScreen extends StatefulWidget {
  final ChatDelegate delegate;
  const _ChatScreen({
    Key? key,
    required this.delegate,
  }) : super(key: key);

  @override
  State<_ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<_ChatScreen> {
  final _chatController = ChatController.instance;
  late Group group;
  User? user;
  final ScrollController _scrollController = ScrollController();
  QueryDocumentSnapshot<Map<String, dynamic>>? lastDocument;
  final ValueNotifier<List<Message>> messageNotifier =
      ValueNotifier<List<Message>>([]);
  late final StreamSubscription _messageSubscription;
  final ValueNotifier<bool> showGoToBottom = ValueNotifier<bool>(false);

  @override
  void initState() {
    _chatController.isChatScreen = true;
    group = widget.delegate.group!;
    getMessages();
    _messageSubscription =
        _chatController.getNewMessages(group.id, lastDocument).listen((data) {
      var newMessage = Message.fromJson(data.docs.first.data());
      if (newMessage.idFrom == _chatController.userId) return;
      messageNotifier.value = [newMessage, ...messageNotifier.value];
    });
    _scrollController.addListener(() {
      var height = MediaQuery.of(context).size.height;
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
    super.initState();
  }

  getMessages() async {
    var data = await _chatController.getInitialMessages(group.id, lastDocument);
    if (data.docs.isNotEmpty) {
      lastDocument = data.docs.last;
      var tempMessageList = <Message>[];
      for (var messageSnapshot in data.docs) {
        tempMessageList.add(Message.fromJson(messageSnapshot.data()));
      }
      messageNotifier.value = [...messageNotifier.value, ...tempMessageList];
    }
  }

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot<Object?>>(
            stream: _chatController.getGroupUserStream(group),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return widget.delegate.chatAppbarBuilder(context, null, false);
              }
              try {
                user = User.fromJson(
                    snapshot.data!.data() as Map<String, dynamic>);
              } catch (e) {
                debugPrint(e.toString());
              }
              if (user == null) {
                return widget.delegate.chatAppbarBuilder(context, null, false);
              }
              var isTyping = group.id == user!.typingGroup;
              return widget.delegate
                  .chatAppbarBuilder(context, user!, isTyping);
            },
          ),
          Expanded(
            child: ValueListenableBuilder<List<Message>>(
              valueListenable: messageNotifier,
              builder: (context, value, _) {
                return Stack(
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
                                            : Colors.white.withOpacity(0.85),
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                        Icons.keyboard_double_arrow_down),
                                  ));
                            } else {
                              return const SizedBox();
                            }
                          },
                        ))
                  ],
                );
              },
            ),
          ),
          widget.delegate.chatBottomBuilder(_onSendTapped, _onCameraPressed,
              _onGalleryPressed, _onLocationPressed),
        ],
      ),
    );
  }

  void _onSendTapped(String text) {
    if (user == null) return;
    String currTime = DateTime.now().millisecondsSinceEpoch.toString();
    var message = Message(
        content: text,
        idFrom: _chatController.userId ?? "",
        idTo: _chatController.getRecepientFromGroup(group),
        timestamp: currTime);
    messageNotifier.value = [message, ...messageNotifier.value];
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    _chatController.sendMessage(
        message: message,
        group: group,
        notificationTitle: widget.delegate.notificationTitle(group, user!));
  }

  _onCameraPressed() async {
    var navigator = Navigator.of(context);
    var image = await widget.delegate.getCameraImage();
    navigator.pop();
    if (image == null) return;

    // adding local image while the image uploads
    String currTime = DateTime.now().millisecondsSinceEpoch.toString();
    var message = Message(
        type: MessageType.image,
        content: image.path,
        idFrom: _chatController.userId ?? "",
        idTo: _chatController.getRecepientFromGroup(group),
        timestamp: currTime);
    messageNotifier.value = [message, ...messageNotifier.value];
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    var url = await widget.delegate.uploadImage(image);
    if (url == null) return;
    _chatController.sendMessage(
        message: message.copyWith(content: url),
        group: group,
        notificationTitle: widget.delegate.notificationTitle(group, user!));
  }

  _onGalleryPressed() async {
    var navigator = Navigator.of(context);
    var image = await widget.delegate.getGalleryImage();
    navigator.pop();
    if (image == null) return;

    // adding local image while the image uploads
    String currTime = DateTime.now().millisecondsSinceEpoch.toString();
    var message = Message(
        type: MessageType.image,
        content: image.path,
        idFrom: _chatController.userId ?? "",
        idTo: _chatController.getRecepientFromGroup(group),
        timestamp: currTime);
    messageNotifier.value = [message, ...messageNotifier.value];
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    var url = await widget.delegate.uploadImage(image);
    if (url == null) return;
    _chatController.sendMessage(
        message: message.copyWith(content: url),
        group: group,
        notificationTitle: widget.delegate.notificationTitle(group, user!));
  }

  _onLocationPressed(BuildContext context) async {
    var navigator = Navigator.of(context);
    var latlng = await widget.delegate.getCurrentLocation(context);
    navigator.pop();

    if (latlng == null) return;

    // adding local location
    String currTime = DateTime.now().millisecondsSinceEpoch.toString();
    var message = Message(
        type: MessageType.location,
        content: "${latlng.latitude},${latlng.longitude}",
        idFrom: _chatController.userId ?? "",
        idTo: _chatController.getRecepientFromGroup(group),
        timestamp: currTime);
    messageNotifier.value = [message, ...messageNotifier.value];
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    _chatController.sendMessage(
        message: message,
        group: group,
        notificationTitle: widget.delegate.notificationTitle(group, user!));
  }

  @override
  void dispose() {
    _chatController.isChatScreen = false;
    _messageSubscription.cancel();
    _scrollController.dispose();
    messageNotifier.dispose();
    super.dispose();
  }
}
