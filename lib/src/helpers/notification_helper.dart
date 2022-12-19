import 'dart:convert';

import 'package:http/http.dart' as http;

import '../controllers/chat_controller.dart';

class NotificationHelper {
  final _chatController = ChatController.instance;
  Future<void> sendPushNotification(String? title, dynamic userToken,
      String? body, Map<String, dynamic>? payload, String groupId,
      {int? badgeCount}) async {
    if (_chatController.fcmServerKey == null) return;

    if (body == null) return;

    if (body.length > 800) {
      body = '${body.substring(0, 800)}...';
    }

    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final headers = {
      'content-type': 'application/json',
      'Authorization': 'key=${_chatController.fcmServerKey}'
    };

    final data = {
      'notification': {
        'body': body,
        'title': title,
        'sound': 'default',
        'badge': badgeCount
      },
      'priority': 'high',
      'data': payload,
      'registration_ids': userToken,
    };

    await http.post(Uri.parse(postUrl),
        body: jsonEncode(data), headers: headers);
  }
}
