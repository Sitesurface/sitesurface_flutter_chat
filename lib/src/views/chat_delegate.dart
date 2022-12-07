import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_chat/sitesurface_flutter_chat.dart';
import 'package:sitesurface_flutter_chat/src/helpers/image_helper.dart';

import '../widget/message_item.dart';

abstract class ChatDelegate<T> {
  Widget titleBuilder(BuildContext context, User user, bool isTyping);
  Group? group;

  /// notification title which is sent to user
  String notificationTitle(Group group, User user);
  Future<String?> uploadImage(File file) async {
    var imageHelper = ImageHelper();
    return await imageHelper.uploadImageFile(file);
  }

  Widget chatMessageBuilder(BuildContext context, int index, Message message,
      String currUserId, List<Message> listMessage) {
    return MessageItem(
        index: index,
        message: message,
        currUserId: currUserId,
        context: context,
        listMessage: listMessage);
  }

  Future<File?> getCameraImage();
  Future<File?> getGalleryImage();
  Future<SfcLatLng?> getCurrentLocation();
}
