import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sitesurface_flutter_chat/sitesurface_flutter_chat.dart';
import 'package:sitesurface_flutter_chat/src/controllers/chat_controller.dart';
import 'package:sitesurface_flutter_chat/src/utils/try_parse.dart';

class ChatListWidget extends StatefulWidget {
  final ChatDelegate delegate;
  const ChatListWidget(
      {super.key, required this.builder, required this.delegate});
  final Widget Function(BuildContext context, User user, Group group, int index)
      builder;
  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  final _chatController = ChatController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _chatController.getChats(limit: 10),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "No chats found",
                ),
              ],
            ),
          );
        } else {
          return ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(
              height: 5,
            ),
            itemCount: snapshot.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              var group = tryParse<Group?>(
                  Group.fromJson, snapshot.data!.docs[index].data());
              if (group == null) return const SizedBox();
              if (group.unreadMessageCount > 0) {
                if (_chatController.userId == group.lastMessage?.idFrom) {
                  group = group.copyWith(unreadMessageCount: 0);
                }
              }
              return StreamBuilder<DocumentSnapshot<Object?>>(
                  stream: _chatController.getUserStream(
                      _chatController.getRecepientFromGroup(group)),
                  builder: (context, userSnapshot) {
                    if (!userSnapshot.hasData) return const SizedBox();
                    var user = tryParse<User>(User.fromJson,
                        userSnapshot.data!.data() as Map<String, dynamic>);
                    if (user == null) return const SizedBox();
                    return GestureDetector(
                      onTap: () {
                        showChat(
                            context: context,
                            delegate: widget.delegate,
                            group: group!);
                      },
                      child: AbsorbPointer(
                        absorbing: true,
                        child: widget.builder(context, user, group!, index),
                      ),
                    );
                  });
            },
          );
        }
      },
    );
  }
}
