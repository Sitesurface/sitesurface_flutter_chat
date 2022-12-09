import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as ln;
import 'package:sitesurface_flutter_chat/sitesurface_flutter_chat.dart';
import 'package:sitesurface_flutter_chat/src/controllers/chat_controller.dart';
import 'package:sitesurface_flutter_chat/src/enums/message_type.dart';
import 'package:sitesurface_flutter_chat/src/utils/debouncer.dart';
import 'package:sitesurface_flutter_chat/src/utils/theme/inherited_chat_theme.dart';

part '../views/chat.dart';

class ChatHandler extends StatefulWidget {
  final Widget child;
  final ChatDelegate chatDelegate;
  final String userId;
  final String? name;
  final String? profilePic;
  final Map<String, dynamic>? data;
  final String? fcmServerKey;

  const ChatHandler({
    Key? key,
    required this.child,
    required this.userId,
    required this.chatDelegate,
    required this.data,
    this.name,
    this.profilePic,
    this.fcmServerKey,
  }) : super(key: key);

  @override
  State createState() => ChatHandlerState();
}

class ChatHandlerState extends State<ChatHandler> with WidgetsBindingObserver {
  late Widget child;

  final ln.FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      ln.FlutterLocalNotificationsPlugin();
  ln.AndroidNotificationChannel channel = const ln.AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: ln.Importance.high);

  final ChatController _chatController = ChatController();

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _chatController.logout();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    FlutterAppBadger.removeBadge();
    switch (state) {
      case AppLifecycleState.resumed:
        _chatController.setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        _chatController.setUserState(false);
    }
  }

  @override
  void initState() {
    super.initState();
    _chatController.init(
        fcmServerKey: widget.fcmServerKey,
        userId: widget.userId,
        data: widget.data,
        name: widget.name,
        profilePic: widget.profilePic);
    initMain();
    WidgetsBinding.instance.addObserver(this);
    child = widget.child;
    FirebaseMessaging.onMessage.listen((message) async {
      var group = getGroupFromMessage(message);
      if (group == null) return;
      if (group.id == _chatController.activeChatScreen) return;
      flutterLocalNotificationsPlugin.show(
          message.notification.hashCode,
          message.notification?.title ?? '',
          message.notification?.body ?? '',
          ln.NotificationDetails(
            android: ln.AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.blue,
              icon: '@mipmap/ic_launcher',
            ),
          ),
          payload: jsonEncode(message.data));
    });

    //When app is in Active State
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {
        var group = getGroupFromMessage(message);
        if (group == null) return;
        screenNav(group);
      },
    );
    //When app is in Killed State
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      var group = getGroupFromMessage(message);
      if (group == null) return;
      screenNav(group);
    });
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }

  Group? getGroupFromMessage(RemoteMessage? message) {
    try {
      if (_chatController.userId == null) return null;
      if (message == null) return null;
      if (message.data["id"] != "sitesurface_flutter_chat") return null;
      var group = Group.fromJson(jsonDecode(message.data["data"]));
      return group;
    } catch (e) {
      return null;
    }
  }

  void screenNav(Group group) {
    try {
      widget.chatDelegate.group = group;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => _ChatScreen(delegate: widget.chatDelegate),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future initMain() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    const initializationSettingsAndroid =
        ln.AndroidInitializationSettings('@mipmap/ic_launcher');

    ln.DarwinInitializationSettings initializationSettingsIOS =
        ln.DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {
              debugPrint(payload);
            });

    var initializationSettings = ln.InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (notificationResponse) async {
      if (notificationResponse.payload == null) return;
      var message = jsonDecode(notificationResponse.payload!);
      screenNav(message);
    });
  }
}
