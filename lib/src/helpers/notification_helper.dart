import 'dart:convert';

import 'package:sitesurface_flutter_chat/src/controllers/chat_controller.dart';
import 'package:http/http.dart' as http;

class NotificationHelper {
  final _chatController = ChatController.instance;
  Future<void> sendPushNotification(
      String? title, var userToken, String? body, Map<String, dynamic>? payload,
      {int? badgeCount}) async {
    if (_chatController.fcmServerKey == null) return;
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final headers = {
      'content-type': 'application/json',
      'Authorization': "key=${_chatController.fcmServerKey}"
    };

    final data = {
      "notification": {
        "body": body,
        "title": title,
        "sound": "default",
        "badge": badgeCount
      },
      "priority": "high",
      "data": payload,
      "registration_ids": userToken,
    };

    await http.post(Uri.parse(postUrl),
        body: jsonEncode(data), headers: headers);
  }
}
