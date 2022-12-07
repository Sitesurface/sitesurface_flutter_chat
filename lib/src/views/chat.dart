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
  String? chatfield;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  final ValueNotifier<String?> textNotifier = ValueNotifier<String?>(null);
  final ValueNotifier<List<Message>> messageNotifier =
      ValueNotifier<List<Message>>([]);
  late final StreamSubscription _messageSubscription;

  @override
  void initState() {
    _chatController.isChatScreen = true;
    group = widget.delegate.group!;
    _messageSubscription = _chatController.getMessages(group.id).listen((data) {
      var tempMessageList = <Message>[];
      for (var messageSnapshot in data.docs) {
        tempMessageList.add(Message.fromJson(messageSnapshot.data()));
      }
      messageNotifier.value = tempMessageList;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: colorScheme.primary,
        centerTitle: false,
        title: StreamBuilder<DocumentSnapshot<Object?>>(
          stream: _chatController.getGroupUserStream(group),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }
            try {
              user =
                  User.fromJson(snapshot.data!.data() as Map<String, dynamic>);
            } catch (e) {
              debugPrint(e.toString());
            }
            if (user == null) return const SizedBox();
            var isTyping = group.id == user!.typingGroup;
            return widget.delegate.titleBuilder(context, user!, isTyping);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder<List<Message>>(
              valueListenable: messageNotifier,
              builder: (context, value, _) {
                return ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  itemCount: value.length,
                  reverse: true,
                  controller: _scrollController,
                  itemBuilder: (context, index) => widget.delegate
                      .chatMessageBuilder(context, index, value[index],
                          _chatController.userId!, value),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Flexible(
                      child: TextField(
                    controller: _textEditingController,
                    onChanged: (value) {
                      textNotifier.value = value;
                    },
                    decoration: const InputDecoration(
                      hintText: "Message",
                      fillColor: Colors.white,
                      filled: true,
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(
                    width: 8,
                  ),
                  ValueListenableBuilder<String?>(
                      valueListenable: textNotifier,
                      builder: (context, value, _) {
                        if (value == null || value.trim().isEmpty) {
                          return CircleIconButton(
                            onTap: _onAttachmentTapped,
                            icon: Transform.rotate(
                                angle: 50 * math.pi / 180,
                                child: const Icon(
                                  Icons.attachment,
                                  color: Colors.white,
                                )),
                          );
                        } else {
                          return CircleIconButton(
                            onTap: _onSendTapped,
                            iconData: Icons.send,
                          );
                        }
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSendTapped() {
    if (user == null) return;
    _textEditingController.clear();
    String currTime = DateTime.now().millisecondsSinceEpoch.toString();
    var message = Message(
        content: textNotifier.value ?? "",
        idFrom: _chatController.userId ?? "",
        idTo: _chatController.getRecepientFromGroup(group),
        timestamp: currTime);
    messageNotifier.value = [...messageNotifier.value, message];
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    _chatController.sendMessage(
        message: message,
        group: group,
        notificationTitle: widget.delegate.notificationTitle(group, user!));
    textNotifier.value = null;
  }

  void _onAttachmentTapped() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            height: 130,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleIconButton(
                      color: Colors.redAccent,
                      onTap: _onCameraPressed,
                      iconData: Icons.camera,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text("Camera"),
                  ],
                ),
                Column(
                  children: [
                    CircleIconButton(
                      color: Colors.purpleAccent,
                      onTap: _onGalleryPressed,
                      iconData: Icons.photo,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text("Gallery"),
                  ],
                ),
                Column(
                  children: [
                    CircleIconButton(
                      color: Colors.lightGreen,
                      onTap: () => _onLocationPressed(context),
                      iconData: Icons.map,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text("Location"),
                  ],
                )
              ],
            ),
          );
        });
  }

  _onCameraPressed() async {
    var image = await widget.delegate.getCameraImage();
    if (image == null) return;

    // adding local image while the image uploads
    String currTime = DateTime.now().millisecondsSinceEpoch.toString();
    var message = Message(
        content: image.path,
        idFrom: _chatController.userId ?? "",
        idTo: _chatController.getRecepientFromGroup(group),
        timestamp: currTime);
    messageNotifier.value = [...messageNotifier.value, message];
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
    var image = await widget.delegate.getGalleryImage();
    if (image == null) return;

    // adding local image while the image uploads
    String currTime = DateTime.now().millisecondsSinceEpoch.toString();
    var message = Message(
        content: image.path,
        idFrom: _chatController.userId ?? "",
        idTo: _chatController.getRecepientFromGroup(group),
        timestamp: currTime);
    messageNotifier.value = [...messageNotifier.value, message];
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
    var latlng = await widget.delegate.getCurrentLocation(context);
    if (latlng == null) return;

    // adding local location
    String currTime = DateTime.now().millisecondsSinceEpoch.toString();
    var message = Message(
        content: "${latlng.latitude},${latlng.longitude}",
        idFrom: _chatController.userId ?? "",
        idTo: _chatController.getRecepientFromGroup(group),
        timestamp: currTime);
    messageNotifier.value = [...messageNotifier.value, message];
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
    _textEditingController.dispose();
    textNotifier.dispose();
    messageNotifier.dispose();
    super.dispose();
  }
}
