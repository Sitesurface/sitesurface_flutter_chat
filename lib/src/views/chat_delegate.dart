import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitesurface_flutter_chat/sitesurface_flutter_chat.dart';
import 'package:sitesurface_flutter_chat/src/helpers/image_helper.dart';
import 'package:sitesurface_flutter_chat/src/utils/locale/chat_l10n.dart';
import 'package:sitesurface_flutter_chat/src/utils/locale/inherited_chat_locale.dart';
import 'package:sitesurface_flutter_chat/src/utils/theme/chat_theme.dart';
import 'package:sitesurface_flutter_chat/src/utils/theme/inherited_chat_theme.dart';

import '../widget/chat_bottom_widget.dart';
import '../widget/message_item.dart';

abstract class ChatDelegate<T> {
  Group? group;

  ChatTheme chatTheme() {
    return const DefaultChatTheme();
  }

  ChatL10n chatL10n() {
    return EnChatL10n();
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

  Widget chatAppbarBuilder(BuildContext context, User? user, bool isTyping) {
    final theme = InheritedChatTheme.of(context).theme;
    final l10n = InheritedL10n.of(context).l10n;
    return AppBar(
      foregroundColor: theme.appBarForegroundColor,
      backgroundColor:
          theme.appBarBackgroundColor ?? Theme.of(context).primaryColor,
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
                        style: theme.appbarNameStyle,
                      ),
                      () {
                        if (isTyping) {
                          return Text(
                            l10n.typingLabel,
                            style: theme.appBarTypingTextStyle,
                          );
                        } else if (user.isActive) {
                          return Text(l10n.onlineLabel,
                              style: theme.appBarOnlineStyle);
                        } else {
                          var lastSeen =
                              "${l10n.lastSeenLabel} ${DateFormat("dd MMMM, hh:mm aa").format(DateTime.fromMillisecondsSinceEpoch(int.parse(user.lastSeen ?? "")))}";
                          return Text(lastSeen, style: theme.lastSeenStyle);
                        }
                      }(),
                    ],
                  ),
                ),
              ],
            ),
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
}
