import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_chat/sitesurface_flutter_chat.dart';
import 'package:sitesurface_flutter_chat/src/controllers/chat_controller.dart';
import 'package:sitesurface_flutter_chat/src/helpers/image_helper.dart';

import '../widget/chat_bottom_widget.dart';
import '../widget/message_item.dart';

abstract class ChatDelegate<T> {
  Group? group;

  ChatTheme chatTheme() {
    return const DefaultChatTheme();
  }

  ChatL10n chatL10n() {
    return const EnChatL10n();
  }

  /// notification title which is sent to user
  String notificationTitle(Group group, User user) {
    return user.name ?? "";
  }

  Future<String?> uploadImage(File file) async {
    var imageHelper = ImageHelper();
    return await imageHelper.uploadImageFile(file);
  }

  Widget chatMessageBuilder(BuildContext context, int index, Message message,
      String currUserId, List<Message> listMessage) {
    return MessageItem(
        openMap: launchMap,
        index: index,
        message: message,
        currUserId: currUserId,
        context: context,
        listMessage: listMessage);
  }

  Widget chatAppbarBuilder(User? user, bool isTyping, Group group) {
    return SfcAppBar(
      user: user,
      isTyping: isTyping,
      actions: const [],
    );
  }

  Widget chatBottomBuilder(
      TextEditingController controller,
      void Function(String text)? onSendTapped,
      void Function()? onCameraTapped,
      void Function()? onGalleryTapped,
      void Function(BuildContext context)? onLocationTapped) {
    return ChatBottomWidget(
      textEditingController: controller,
      onSendTapped: onSendTapped,
      onCameraTapped: onCameraTapped,
      onGalleryTapped: onGalleryTapped,
      onLocationTapped: onLocationTapped,
    );
  }

  Future<void> launchMap(String url) async {}

  Future<File?> getCameraImage();
  Future<File?> getGalleryImage();
  Future<SfcLatLng?> getCurrentLocation(BuildContext context);

  Future<void> updateUserData(
      {String? name, String? profilePic, Map<String, dynamic>? data}) async {
    var chatController = ChatController.instance;
    await chatController.updateUserData(
        name: name, profilePic: profilePic, data: data);
  }

  Future<void> updateGroupData(
      {required Map<String, dynamic> data, required Group group}) async {
    var chatController = ChatController.instance;
    await chatController.updateGroupData(data: data, group: group);
  }
}
