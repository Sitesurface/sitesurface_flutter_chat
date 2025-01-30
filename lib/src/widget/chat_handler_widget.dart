import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as ln;
import '../../sitesurface_flutter_chat.dart';
import '../controllers/chat_controller.dart';

import '../views/chat_screen.dart';

/// Wrap your widget with this widget and pass the required parameter [userId] to get started.
/// If you are using the default widgets i.e., you have not overidden any UI in [ChatDelegate] then it is
/// required to pass [name] and [profilePic].
class ChatHandler extends StatefulWidget {
  /// child widget
  final Widget child;

  /// [chatDelegate] which needs to be used for this widget
  /// extend [ChatDelegate] and pass that class here
  final ChatDelegate chatDelegate;

  /// Unique id of currently logged in user
  /// Important: this widget should not be used if user is not logged in
  final String userId;

  /// Name of the currently logged in user. [name] is displayed in notification and appbar titles by default
  final String? name;

  /// Profile pic of the currently logged in user. It is displayed in the chats list and chatting page by default
  final String? profilePic;

  /// Pass any extra data which you want to save. You will get this data back in all the callbacks where you get
  /// [User] object
  final Map<String, dynamic>? data;

  /// FCM Server key of your firebase project to send push notifications. This package currently uses legacy api to send
  /// notifications so kindly enable that in your project to get key.
  final String? fcmServerKey;

  final String notificationIconPath;

  /// You can pass your own custom function to get current time of user. This object of [DateTime] is used internally
  /// by the package to save timestamps for many documents which is used while querying.
  /// By default it is retrieved using [DateTime.now().millisecondsSinceEpoch] .
  /// But it is advised passing your own function which uses your own custom server to get time as if user changes time
  /// on his device it can mess up the chats.
  final Future<DateTime> Function()? getCurrentTimeUserDefined;

  const ChatHandler(
      {super.key,
      required this.child,
      required this.chatDelegate,
      required this.userId,
      this.name,
      this.profilePic,
      this.data,
      this.fcmServerKey,
      this.getCurrentTimeUserDefined,
      this.notificationIconPath = '@mipmap/ic_launcher'});

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
    await FlutterAppBadger.removeBadge();
    switch (state) {
      case AppLifecycleState.resumed:
        await _chatController.setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        await _chatController.setUserState(false);
      case AppLifecycleState.hidden:
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
        profilePic: widget.profilePic,
        getCurrentTimeUserDefined: widget.getCurrentTimeUserDefined);
    initMain();
    WidgetsBinding.instance.addObserver(this);
    child = widget.child;
    FirebaseMessaging.onMessage.listen((message) async {
      final group = getGroupFromMessage(message);
      if (group == null) return;
      if (group.id == _chatController.activeChatScreen) return;
      await flutterLocalNotificationsPlugin.show(
          message.notification.hashCode,
          message.notification?.title ?? '',
          message.notification?.body ?? '',
          ln.NotificationDetails(
            android: ln.AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.blue,
              icon: widget.notificationIconPath,
            ),
          ),
          payload: jsonEncode(message.data));
    });

    //When app is in Active State
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) async {
        final group = getGroupFromMessage(message);
        if (group == null) return;
        screenNav(group);
      },
    );
    //When app is in Killed State
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      final group = getGroupFromMessage(message);
      if (group == null) return;
      screenNav(group);
    });
  }

  @override
  Widget build(BuildContext context) => child;

  Group? getGroupFromMessage(RemoteMessage? message) {
    try {
      if (_chatController.userId == null) return null;
      if (message == null) return null;
      if (message.data['id'] != 'sitesurface_flutter_chat') return null;
      final group = Group.fromJson(jsonDecode(message.data['data']));
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
          builder: (context) => ChatScreen(delegate: widget.chatDelegate),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future initMain() async {
    final messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final initializationSettingsAndroid =
        ln.AndroidInitializationSettings(widget.notificationIconPath);

    final initializationSettingsIOS = ln.DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final initializationSettings = ln.InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (notificationResponse) async {
      if (notificationResponse.payload == null) return;
      final message = jsonDecode(notificationResponse.payload!);
      if (message['id'] != 'sitesurface_flutter_chat') return;
      final group = Group.fromJson(jsonDecode(message['data']));
      screenNav(group);
    });
  }
}
