import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_chat/sitesurface_flutter_chat.dart';
import 'package:sitesurface_flutter_chat/src/controllers/chat_controller.dart';
import 'package:sitesurface_flutter_chat/src/views/chat_screen.dart';

void openChat(
    {required BuildContext context,
    required ChatDelegate delegate,
    required String recepientId,
    String? orderId,
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
