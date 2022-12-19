---
sidebar_position: 1
id: advance-usage
title: Advance Usage
---

There are many functions available in `ChatDelegate` which you can override to customize the chat app. We'll go through them here.

- `String notificationTitle(Group group, User user)` - The string returned by this will be shown in the title of notification received by other user.

- `Future<String?> uploadImage(File file)` - By default this package uses `firebase_storage` to upload the images. You can override this function and pass your own implementation. After your image is uploaded you can return it's url.

- `Widget chatMessageBuilder(BuildContext context, int index, Message message, String currUserId ,List<Message> listMessage)` - The messages widget shown in chat screen. You can build your own custom widget for messages by overriding this.

- `Widget chatAppbarBuilder( BuildContext context, User? user, bool isTyping, Group group)` - The appbar widget shown in chat screen. You can build your own custom appbar for chat screen by overriding this.

* `Widget chatBottomBuilder(TextEditingController controller, void Function(String text)? onSendTapped, void Function()? onCameraTapped, void Function()? onGalleryTapped, void Function(BuildContext context)? onLocationTapped)` - The bottom widget for sending message and attachments. You can override this function to build your own custom UI for bottom widget of chat screen. Make sure to add `controller` to your `TextField` or `TextFormField`.

* `Future<void> launchMap(String url)` - If you use default UI then override this function and provide your own implementation for launching url using any package like [url_launcher](https://pub.dev/packages/url_launcher).

## Update current user data

For updating current user data you can call `Future<void> updateUserData({String? name, String? profilePic, Map<String, dynamic>? data})` function of `ChatDelegate`. Here `data` is the custom data of user which you send in `ChatHandler`.

## Update group data

For updating group data you can call `Future<void> updateGroupData({required Map<String, dynamic> data, required Group group})` function of `ChatDelegate`. Here `data` is the custom data of your group. And the `group` which you want to update.
