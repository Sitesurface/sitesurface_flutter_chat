import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../enums/message_type.dart';
import '../helpers/notification_helper.dart';
import '../models/group/group.dart';
import '../models/message/message.dart';
import '../models/user/user.dart';

class ChatController {
  static final ChatController _obj = ChatController._internal();

  static ChatController get instance => _obj;

  final _userCollection = FirebaseFirestore.instance.collection('users');
  final _groupCollection = FirebaseFirestore.instance.collection('groups');
  final _messageCollection = FirebaseFirestore.instance.collection('messages');

  String? activeChatScreen;
  Future<DateTime> Function()? getCurrentTimeUserDefined;

  String? _userId;
  String? fcmServerKey;

  factory ChatController() => _obj;

  String? get userId => _userId;

  ChatController._internal();

  Future<void> init(
      {required String userId,
      String? fcmServerKey,
      String? name,
      String? profilePic,
      Map<String, dynamic>? data,
      Future<DateTime> Function()? getCurrentTimeUserDefined}) async {
    this.fcmServerKey = fcmServerKey;
    this.getCurrentTimeUserDefined = getCurrentTimeUserDefined;
    _userId = userId;
    final fcmToken = await FirebaseMessaging.instance.getToken();
    final userDoc = await _userCollection.doc(_userId).get();
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
        fcmTokens: currentTokens,
        isActive: true,
      );
      await _userCollection
          .doc(_userId)
          .set(user.toJson(), SetOptions(merge: true));
    } else {
      if (_userId == null) return;
      final user = User(
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
    checkUserId();
    final userMap = user.toJson();

    // removing fields which shouldn't be updated
    final nonEditableFields = [
      'createdAt',
      'id',
    ];

    for (var key in nonEditableFields) {
      userMap.remove(key);
    }

    await _userCollection.doc(_userId).set(userMap, SetOptions(merge: true));
  }

  Future<void> updateUserData(
      {String? name, String? profilePic, Map<String, dynamic>? data}) async {
    final map = <String, dynamic>{};
    if (name != null) {
      map['name'] = name;
    }
    if (profilePic != null) {
      map['profilePic'] = profilePic;
    }
    if (data != null) {
      map['data'] = data;
    }
    await _userCollection.doc(_userId).set(map, SetOptions(merge: true));
  }

  Future<void> updateGroup(Group group) async {
    checkUserId();
    final groupMap = group.toJson();

    // removing fields which shouldn't be updated
    final nonEditableFields = [
      'id',
      'users',
    ];

    for (var key in nonEditableFields) {
      groupMap.remove(key);
    }

    await _groupCollection.doc(group.id).set(groupMap, SetOptions(merge: true));
  }

  Future<void> updateGroupData(
      {required Group group, required Map<String, dynamic> data}) async {
    checkUserId();
    await _groupCollection
        .doc(group.id)
        .set({'data': data}, SetOptions(merge: true));
  }

  Future<void> createGroup(Group group) async {
    checkUserId();
    if (_userId == null) return;
    final newGroup = group.copyWith(
        timestamp: await getCurrentTimestamp(), unreadMessageCount: 0);
    await _groupCollection
        .doc(group.id)
        .set(newGroup.toJson(), SetOptions(merge: true));
  }

  Stream<DocumentSnapshot> getUserStream(String userId) {
    checkUserId();
    return _userCollection.doc(userId).snapshots();
  }

  String getRecepientFromGroup(Group group) {
    checkUserId();
    return group.users.firstWhere((element) => _userId != element);
  }

  Stream<DocumentSnapshot> getGroupUserStream(Group group) {
    checkUserId();
    if (_userId == null) throw Exception('userId is no');
    final recepientId = group.users.firstWhere((element) => element != _userId);
    return getUserStream(recepientId);
  }

  Future<User?> currentUser() async {
    checkUserId();
    try {
      final userDoc = await _userCollection.doc(_userId).get();
      return User.fromJson(userDoc.data() ?? {});
    } catch (e) {
      return null;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getChats(
      {QueryDocumentSnapshot<Map<String, dynamic>>? lastDocument}) {
    checkUserId();
    var query = _groupCollection
        .where('users', arrayContains: _userId)
        .limit(10)
        .orderBy('timestamp', descending: true);
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }
    return query.get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getNewChat() {
    checkUserId();
    return _groupCollection
        .where('users', arrayContains: _userId)
        .limit(10)
        .orderBy('timestamp', descending: true)
        .limit(10)
        .snapshots();
  }

  Query<Map<String, dynamic>> getInitialMessages(String groupId) {
    checkUserId();
    resetUnreadMessages(groupId);
    var query = _messageCollection
        .doc(groupId)
        .collection(groupId)
        .orderBy('timestamp', descending: true);
    return query;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUnreadChatsCount() {
    checkUserId();
    return _groupCollection
        .where('unreadMessageCount', isGreaterThan: 0)
        .where('users', arrayContains: _userId)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getNewMessages(String groupId) {
    checkUserId();
    resetUnreadMessages(groupId);
    return _messageCollection
        .doc(groupId)
        .collection(groupId)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots();
  }

  Future<void> logout() async {
    checkUserId();
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      final userDoc = await _userCollection.doc(_userId).get();
      final user = User.fromJson(userDoc.data() ?? {});
      final currentTokens = <String>[];
      currentTokens.addAll(user.fcmTokens);
      currentTokens.remove(fcmToken);
      await updateUser(user.copyWith(fcmTokens: currentTokens));
      await setUserState(false);
      _userId = null;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void resetUnreadMessages(String groupId) async {
    checkUserId();
    try {
      final groupDoc = await _groupCollection.doc(groupId).get();
      if (!groupDoc.exists) return;
      final group = Group.fromJson(groupDoc.data() ?? {});
      if (group.lastMessage == null) return;
      if (group.lastMessage?.idFrom == _userId) return;
      await updateGroup(group.copyWith(unreadMessageCount: 0));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> sendNotification(
      {required Group group,
      required Message message,
      required String title}) async {
    checkUserId();
    try {
      final notifificationHelper = NotificationHelper();
      var body = '';
      switch (message.type) {
        case MessageType.text:
          body = message.content;
          break;
        case MessageType.image:
          body = 'Shared Image';
          break;
        case MessageType.location:
          body = 'Shared Location';
          break;
      }
      final recepientDoc = await _userCollection
          .doc(group.users.firstWhere((element) => _userId != element))
          .get();
      final recepientUser = User.fromJson(recepientDoc.data() ?? {});
      await notifificationHelper.sendPushNotification(
        title,
        recepientUser.fcmTokens,
        body,
        {
          'id': 'sitesurface_flutter_chat',
          'data': jsonEncode(
            group.toJson(),
          ),
        },
        group.id,
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
    checkUserId();
    try {
      if (_userId == null) return;
      final currTime = await getCurrentTimestamp();
      if (message.content.trim().isEmpty) return;
      final tempGroup = await getGroup(group.id);
      if (tempGroup != null) group = tempGroup;
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
    checkUserId();
    try {
      final currTime = await getCurrentTimestamp();
      final userDoc = await _userCollection.doc(_userId).get();
      final user = User.fromJson(userDoc.data() ?? {});
      await updateUser(user.copyWith(lastSeen: currTime, isActive: isActive));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<Group?> getGroup(String groupId) async {
    checkUserId();
    try {
      final groupDoc = await _groupCollection.doc(groupId).get();
      final group = Group.fromJson(groupDoc.data() ?? {});
      return group;
    } catch (e) {
      return null;
    }
  }

  Future<void> updateTyping(String? groupId) async {
    checkUserId();
    try {
      await _userCollection
          .doc(_userId)
          .set({'typingGroup': groupId}, SetOptions(merge: true));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void checkUserId() {
    if (_userId == null) throw Exception('userId is not initialised');
  }

  Future<String> getCurrentTimestamp() async {
    if (getCurrentTimeUserDefined == null) {
      return DateTime.now().millisecondsSinceEpoch.toString();
    } else {
      final currentDate = await getCurrentTimeUserDefined!();
      return currentDate.toUtc().millisecondsSinceEpoch.toString();
    }
  }
}
