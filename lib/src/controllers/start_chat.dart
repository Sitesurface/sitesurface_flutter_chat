import 'package:flutter/material.dart';

import '../../sitesurface_flutter_chat.dart';
import '../views/chat_screen.dart';
import 'chat_controller.dart';

/// Use this to start new chat or continue existing chat
void openChat(
    {required BuildContext context,

    /// pass chat delegate to customize the UI of chatting page
    required ChatDelegate delegate,

    /// user id of recepient
    required String recepientId,

    /// If you want to make the chat unique to an order then pass unique order id
    String? orderId,

    /// custom data which you want to save in [Group].
    Map<String, dynamic>? groupData}) {
  var groupId = '';
  final currentUserId = ChatController.instance.userId;
  if (currentUserId == null) return;
  if (orderId == null) {
    groupId = _getId([currentUserId, recepientId]);
  } else {
    groupId = _getId([currentUserId, recepientId, orderId]);
  }
  final group =
      Group(id: groupId, users: [currentUserId, recepientId], data: groupData);
  delegate.group = group;
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => ChatScreen(delegate: delegate)));
}

String _getId(List<String> array) {
  final sortedArray = <String>[];
  array.sort((a, b) => a.compareTo(b));
  sortedArray.addAll(array);
  return sortedArray.join('|');
}
