import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_chat/sitesurface_flutter_chat.dart';
import 'package:sitesurface_flutter_chat/src/controllers/chat_controller.dart';
import 'package:sitesurface_flutter_chat/src/helpers/image_helper.dart';

import '../widget/chat_bottom_widget.dart';
import '../widget/message_item.dart';

/// You can override almost each part of the UI provided by the package by overriding methods of this class
abstract class ChatDelegate {
  Group? group;

  /// Pass the theme which you want to use for the UI. You can extend [ChatTheme] and customise the theme as per your requirement
  ChatTheme chatTheme() {
    return const DefaultChatTheme();
  }

  /// Pass the locales which you want to use for the UI. You can extend [ChatL10n] and customise the locale as per your requirement
  ChatL10n chatL10n() {
    return const EnChatL10n();
  }

  /// Notification Title which is sent to recepient user when message is sent.
  String notificationTitle(Group group, User user) {
    return user.name ?? "";
  }

  /// By default this package uses [firebase_storage] to upload the images. You can override this function and pass your own implementation.
  Future<String?> uploadImage(File file) async {
    var imageHelper = ImageHelper();
    return await imageHelper.uploadImageFile(file);
  }

  /// Chat message widget which is shown in chatting page. The message widget which is provided by package has
  /// many functionalities provided out of box.
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

  /// Appbar in chatting page
  Widget chatAppbarBuilder(User? user, bool isTyping, Group group) {
    return SfcAppBar(
      user: user,
      isTyping: isTyping,
      actions: const [],
    );
  }

  /// Bottom widget in chatting page
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

  /// If you use default UI then override this function and provide your own implementation for launching url using
  /// any package like [url_launcher].
  Future<void> launchMap(String url) async {}

  /// get image from camera when camera icon pressed in attachments on chatting page
  Future<File?> getCameraImage();

  /// get image from gallery when camera icon pressed in attachments on chatting page
  Future<File?> getGalleryImage();

  /// get user's current location when camera icon pressed in attachments on chatting page
  Future<SfcLatLng?> getCurrentLocation(BuildContext context);

  /// You can use this function to update user data if you update user in your app.
  Future<void> updateUserData(
      {String? name, String? profilePic, Map<String, dynamic>? data}) async {
    var chatController = ChatController.instance;
    await chatController.updateUserData(
        name: name, profilePic: profilePic, data: data);
  }

  /// You can use this function to group data.
  Future<void> updateGroupData(
      {required Map<String, dynamic> data, required Group group}) async {
    var chatController = ChatController.instance;
    await chatController.updateGroupData(data: data, group: group);
  }
}
