import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_chat/src/helpers/image_helper.dart';
import 'package:sitesurface_flutter_chat/src/helpers/notification_helper.dart';
import 'package:sitesurface_flutter_chat/src/models/group/group.dart';
import 'package:sitesurface_flutter_chat/src/models/message/message.dart';
import 'package:sitesurface_flutter_chat/src/models/user/user.dart';

import '../enums/message_type.dart';

class ChatController {
  static final ChatController _obj = ChatController._internal();

  static ChatController get instance => _obj;

  final _userCollection = FirebaseFirestore.instance.collection("users");
  final _groupCollection = FirebaseFirestore.instance.collection("groups");
  final _messageCollection = FirebaseFirestore.instance.collection("messages");

  //TODO: Notifications should show if someone texts from other group
  bool isChatScreen = false;

  String? _userId;
  String? fcmServerKey;

  factory ChatController() {
    return _obj;
  }

  String? get userId => _userId;

  ChatController._internal();

  Future<void> init(
      {required String userId,
      String? fcmServerKey,
      String? name,
      String? profilePic,
      Map<String, dynamic>? data}) async {
    this.fcmServerKey = fcmServerKey;
    _userId = userId;
    var fcmToken = await FirebaseMessaging.instance.getToken();
    var userDoc = await _userCollection.doc(_userId).get();
    if (userDoc.exists) {
      var user = User.fromJson(userDoc.data() ?? {});
      var currentTokens = <String>[];
      currentTokens.addAll(user.fcmTokens);
      if (fcmToken != null) {
        currentTokens.add(fcmToken);
      }
      currentTokens = currentTokens.toSet().toList();
      if (currentTokens.length > 10) {
        currentTokens.removeAt(0);
      }
      user = user.copyWith(
        name: name,
        profilePic: profilePic,
        data: data,
        lastSeen: DateTime.now().microsecondsSinceEpoch.toString(),
        fcmTokens: currentTokens,
        isActive: true,
      );
      await _userCollection
          .doc(_userId)
          .set(user.toJson(), SetOptions(merge: true));
    } else {
      if (_userId == null) return;
      var user = User(
          data: data,
          id: _userId!,
          name: name,
          profilePic: profilePic,
          isActive: true,
          lastSeen: DateTime.now().microsecondsSinceEpoch.toString(),
          createdAt: DateTime.now().microsecondsSinceEpoch.toString(),
          fcmTokens: fcmToken == null ? [] : [fcmToken]);
      await _userCollection.doc(_userId).set(user.toJson());
    }
  }

  Future<void> updateUser(User user) async {
    var userMap = user.toJson();

    // removing fields which shouldn't be updated
    var nonEditableFields = [
      "createdAt",
      "id",
    ];

    for (var key in nonEditableFields) {
      userMap.remove(key);
    }

    await _userCollection.doc(_userId).set(userMap, SetOptions(merge: true));
  }

  Future<void> updateGroup(Group group) async {
    var groupMap = group.toJson();

    // removing fields which shouldn't be updated
    var nonEditableFields = [
      "id",
      "users",
    ];

    for (var key in nonEditableFields) {
      groupMap.remove(key);
    }

    await _groupCollection.doc(group.id).set(groupMap, SetOptions(merge: true));
  }

  Future<void> createGroup(Group group) async {
    var newGroup = group.copyWith(
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        unreadMessageCount: 0);
    await _groupCollection
        .doc(group.id)
        .set(newGroup.toJson(), SetOptions(merge: true));
  }

  Stream<DocumentSnapshot> getUserStream(String userId) =>
      _userCollection.doc(userId).snapshots();

  String getRecepientFromGroup(Group group) =>
      group.users.firstWhere((element) => _userId != element);

  Stream<DocumentSnapshot> getGroupUserStream(Group group) {
    var recepientId = group.users.firstWhere((element) => element != _userId);
    return getUserStream(recepientId);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChats(
      {required int limit, DocumentSnapshot? documentSnapshot}) {
    var query = FirebaseFirestore.instance
        .collection("groups")
        .where("users", arrayContains: _userId)
        .limit(limit)
        .orderBy('timestamp', descending: true);
    if (documentSnapshot != null) {
      query = query.startAfterDocument(documentSnapshot);
    }
    return query.snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String groupId) {
    _resetUnreadMessages(groupId);
    return _messageCollection
        .doc(groupId)
        .collection(groupId)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Future<void> logout() async {
    try {
      var fcmToken = await FirebaseMessaging.instance.getToken();
      var userDoc = await _userCollection.doc(_userId).get();
      var user = User.fromJson(userDoc.data() ?? {});
      var currentTokens = <String>[];
      currentTokens.addAll(user.fcmTokens);
      currentTokens.remove(fcmToken);
      await updateUser(user.copyWith(fcmTokens: currentTokens));
      await setUserState(false);
      _userId = null;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _resetUnreadMessages(String groupId) async {
    try {
      var groupDoc = await _groupCollection.doc(groupId).get();
      if (!groupDoc.exists) return;
      var group = Group.fromJson(groupDoc.data() ?? {});
      if (group.lastMessage == null) return;
      if (group.lastMessage?.idFrom == _userId) return;
      await updateGroup(
          group.copyWith(lastMessage: null, unreadMessageCount: 0));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<int> getUnreadChatCount({
    required Group group,
  }) async {
    var groups = await _groupCollection
        .where("users", arrayContains: _userId)
        .where("unreadMessageCount", isGreaterThan: 0)
        .get();
    return groups.docs.length;
  }

  Future<void> sendNotification(
      {required Group group,
      required Message message,
      required String title}) async {
    try {
      var notifificationHelper = NotificationHelper();
      var body = "";
      switch (message.type) {
        case MessageType.text:
          body = message.content;
          break;
        case MessageType.image:
          body = "Shared Image";
          break;
        case MessageType.location:
          body = "Shared Location";
          break;
      }
      var recepientDoc = await _userCollection
          .doc(group.users.firstWhere((element) => _userId != element))
          .get();
      var recepientUser = User.fromJson(recepientDoc.data() ?? {});
      await notifificationHelper.sendPushNotification(
        title,
        recepientUser.fcmTokens,
        body,
        {
          "id": "sitesurface_flutter_chat",
          "data": jsonEncode(
            group.toJson(),
          ),
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> sendMessage({
    required Message message,
    required Group group,
    required String notificationTitle,
  }) async {
    try {
      if (_userId == null) return;
      String currTime = DateTime.now().millisecondsSinceEpoch.toString();
      if (message.content.trim().isEmpty) return;
      var unreadMessageCount = group.unreadMessageCount;
      unreadMessageCount += 1;
      group = group.copyWith(
        unreadMessageCount: unreadMessageCount,
        lastMessage: message,
        timestamp: currTime,
      );
      if ((await _groupCollection.doc(group.id).get()).exists) {
        await updateGroup(group);
      } else {
        await createGroup(group);
      }

      await _messageCollection
          .doc(group.id)
          .collection(group.id)
          .doc(currTime)
          .set(message.toJson());
      await sendNotification(
          group: group, message: message, title: notificationTitle);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> setUserState(bool isActive) async {
    try {
      String currTime = DateTime.now().millisecondsSinceEpoch.toString();
      var userDoc = await _userCollection.doc(_userId).get();
      var user = User.fromJson(userDoc.data() ?? {});
      await updateUser(user.copyWith(lastSeen: currTime, isActive: isActive));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
