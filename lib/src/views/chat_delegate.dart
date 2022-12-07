import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitesurface_flutter_chat/sitesurface_flutter_chat.dart';
import 'package:sitesurface_flutter_chat/src/helpers/image_helper.dart';

import '../widget/message_item.dart';

abstract class ChatDelegate<T> {
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

  Widget chatAppbarBuilder(BuildContext context, User? user, bool isTyping) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white, //change your color here
      ),
      backgroundColor: colorScheme.primary,
      centerTitle: false,
      title: user == null
          ? const SizedBox()
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.profilePic ?? ""),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        user.name ?? "",
                        style: textTheme.bodyLarge
                            ?.copyWith(fontSize: 18, color: Colors.white),
                      ),
                      () {
                        if (isTyping) {
                          return Text(
                            "Typing....",
                            style: textTheme.bodySmall
                                ?.copyWith(color: Colors.green),
                          );
                        } else if (user.isActive) {
                          return Text("Online",
                              style: textTheme.bodySmall
                                  ?.copyWith(color: Colors.green));
                        } else {
                          var lastSeen =
                              "last seen ${DateFormat("dd MMMM, hh:mm aa").format(DateTime.fromMillisecondsSinceEpoch(int.parse(user.lastSeen ?? "")))}";
                          return Text(lastSeen,
                              style: textTheme.bodySmall
                                  ?.copyWith(color: Colors.white));
                        }
                      }(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Future<File?> getCameraImage();
  Future<File?> getGalleryImage();
  Future<SfcLatLng?> getCurrentLocation(BuildContext context);
}
