import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_chat/sitesurface_flutter_chat.dart';
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
          if (!snapshot.hasData) {
            return builder(context, 0);
          } else {
            if (snapshot.data!.docs.isEmpty) {
              return builder(context, 0);
            } else {
              var groups = <Group>[];
              for (var groupDoc in snapshot.data!.docs) {
                groups.add(Group.fromJson(groupDoc.data()));
              }
              int count = 0;
              for (var group in groups) {
                if (group.lastMessage?.idFrom != _chatController.userId) {
                  count++;
                }
              }
              return builder(context, count);
            }
          }
        });
  }
}
