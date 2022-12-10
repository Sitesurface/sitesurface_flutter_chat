import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitesurface_flutter_chat/sitesurface_flutter_chat.dart';
import 'package:sitesurface_flutter_chat/src/controllers/chat_controller.dart';
import 'package:sitesurface_flutter_chat/src/utils/try_parse.dart';

import '../enums/message_type.dart';

class ChatListWidget extends StatefulWidget {
  final ChatDelegate delegate;
  const ChatListWidget({
    super.key,
    this.builder,
    required this.delegate,
    this.noChatFound,
  });
  final Widget Function(BuildContext context, User user, bool isTyping,
      Group group, int index)? builder;
  final Widget? noChatFound;
  @override
  State<ChatListWidget> createState() => _ChatListWidgetState();
}

class _ChatListWidgetState extends State<ChatListWidget> {
  final _chatController = ChatController();
  final _scrollController = ScrollController();
  QueryDocumentSnapshot<Map<String, dynamic>>? lastDocument;
  final ValueNotifier<List<Group>?> groupNotifier =
      ValueNotifier<List<Group>?>(null);
  late final StreamSubscription _groupSubscription;

  @override
  void initState() {
    getGroups();
    addListeners();
    super.initState();
  }

  getGroups() async {
    var data = await _chatController.getChats(lastDocument: lastDocument);
    if (data.docs.isNotEmpty) {
      lastDocument = data.docs.last;
      var tempGroup = <Group>[];
      for (var groupSnapshot in data.docs) {
        tempGroup.add(Group.fromJson(groupSnapshot.data()));
      }
      groupNotifier.value =
          <Group>{...groupNotifier.value ?? [], ...tempGroup}.toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = widget.delegate.chatTheme();
    var l10n = widget.delegate.chatL10n();
    return ValueListenableBuilder<List<Group>?>(
      valueListenable: groupNotifier,
      builder: (context, data, _) {
        if (data == null) {
          return const SizedBox();
        } else if (data.isEmpty) {
          return widget.noChatFound ??
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.noChatMessagesLabel,
                    ),
                  ],
                ),
              );
        } else {
          return ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(
              height: 5,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              var group = data[index];
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
                    var isTyping = user.typingGroup == group.id;

                    return GestureDetector(
                      onTap: () {
                        showChat(
                            context: context,
                            delegate: widget.delegate,
                            group: group);
                      },
                      child: AbsorbPointer(
                        absorbing: true,
                        child: widget.builder == null
                            ? ListTile(
                                tileColor: theme.chatTileBackgroundColor,
                                leading: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Stack(
                                    children: [
                                      Material(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.network(
                                          user.profilePic ?? "",
                                          errorBuilder: (_, __, ___) =>
                                              Container(),
                                          width: 40.0,
                                          height: 40.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            height: 10,
                                            width: 10,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: () {
                                                  if (user.isActive) {
                                                    return theme
                                                        .onlineIconColor;
                                                  } else {
                                                    return theme
                                                        .offlineIconColor;
                                                  }
                                                }()),
                                            margin:
                                                const EdgeInsets.only(top: 15),
                                          ))
                                    ],
                                  ),
                                ),
                                title: Text(
                                  user.name ?? "",
                                  style: theme.chatTileNameStyle,
                                ),
                                subtitle: isTyping
                                    ? Text(
                                        l10n.typingLabel,
                                        style: theme.chatTileTypingStyle,
                                      )
                                    : Text(
                                        () {
                                          if (group.lastMessage == null) {
                                            return "";
                                          }
                                          switch (group.lastMessage!.type) {
                                            case MessageType.text:
                                              return group
                                                      .lastMessage?.content ??
                                                  "";
                                            case MessageType.image:
                                              return l10n.sharedImageLabel;
                                            case MessageType.location:
                                              return l10n.sharedLocationLabel;
                                          }
                                        }(),
                                        maxLines: 2,
                                        style: theme.chatTileLastMessageStyle,
                                      ),
                                trailing: Column(
                                  children: [
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    if (group.lastMessage != null)
                                      Text(
                                          DateFormat("yMd").format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                              int.parse(group
                                                      .lastMessage?.timestamp ??
                                                  ""),
                                            ),
                                          ),
                                          style: theme.chatTileTimeStyle),
                                    if (group.unreadMessageCount > 0)
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: theme
                                                    .chatTileUnreadMessageCountBackgroundColor ??
                                                Theme.of(context).primaryColor),
                                        padding: const EdgeInsets.all(6),
                                        child: Text(
                                            "${group.unreadMessageCount}",
                                            style: theme
                                                .chatTileUnreadMessageCountTextStyle),
                                      ),
                                  ],
                                ),
                              )
                            : widget.builder!(
                                context, user, isTyping, group, index),
                      ),
                    );
                  });
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _groupSubscription.cancel();
    super.dispose();
  }

  void addListeners() {
    _groupSubscription = _chatController.getNewChat().listen((data) {
      var newGroup = <Group>[];
      for (var groupSnapshot in data.docChanges) {
        if (groupSnapshot.doc.data() == null) continue;
        newGroup.add(Group.fromJson(groupSnapshot.doc.data()!));
      }

      var tempGroup = [...groupNotifier.value ?? []];
      for (var group in newGroup) {
        for (var i = 0; i < tempGroup.length; i++) {
          if (tempGroup[i].id == group.id) {
            tempGroup.removeAt(i);
            continue;
          }
        }
      }

      groupNotifier.value = <Group>{...newGroup, ...tempGroup}.toList();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        getGroups();
      }
    });
  }
}
