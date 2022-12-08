import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_chat/src/controllers/chat_controller.dart';

class UnreadMessageCountWidget extends StatelessWidget {
  final Widget Function(BuildContext context, int count) builder;
  final _chatController = ChatController();
  UnreadMessageCountWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _chatController.getUnreadChatsCount(),
        builder: (context, snapshot) {
          return builder(context, snapshot.data?.docs.length ?? 0);
        });
  }
}
