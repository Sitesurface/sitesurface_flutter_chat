import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_chat/sitesurface_flutter_chat.dart';
import 'package:sitesurface_flutter_chat/src/controllers/chat_controller.dart';
import 'package:sitesurface_flutter_chat/src/views/chat_screen.dart';

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
  String groupId = "";
  var currentUserId = ChatController.instance.userId;
  if (currentUserId == null) return;
  if (orderId == null) {
    groupId = _getId([currentUserId, recepientId]);
  } else {
    groupId = _getId([currentUserId, recepientId, orderId]);
  }
  var group =
      Group(id: groupId, users: [currentUserId, recepientId], data: groupData);
  delegate.group = group;
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => ChatScreen(delegate: delegate)));
}

String _getId(List<String> array) {
  List<String> sortedArray = [];
  array.sort((a, b) => a.compareTo(b));
  sortedArray.addAll(array);
  return sortedArray.join("|");
}
