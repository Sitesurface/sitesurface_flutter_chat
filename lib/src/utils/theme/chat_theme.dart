import 'package:flutter/material.dart';

// For internal usage only. Use values from theme itself.

/// Base chat theme containing all required properties to make a theme.
/// Extend this class if you want to create a custom theme.
@immutable
abstract class ChatTheme {
  /// Background color for chat screen appBar
  final Color? appBarBackgroundColor;

  /// Foreground color for chat screen appBar
  final Color? appBarForegroundColor;

  /// TextStyle for chat screen appBar name
  final TextStyle appbarNameStyle;

  /// TextStyle for online text on chat screen
  final TextStyle appBarOnlineStyle;

  /// TextStyle for Typing text on chat screen
  final TextStyle appBarTypingTextStyle;

  /// TextStyle for Last seen text on chat screen
  final TextStyle lastSeenStyle;

  /// TextStyle for reciever chat message bubble
  final TextStyle recieverMessageStyle;

  /// TextStyle for reciever chat messaege time
  final TextStyle recieverMessageTimeStyle;

  /// Background color for reciever Message bubble
  final Color recieverMessageBackgroundColor;

  /// TextStyle for senders chat message bubble
  final TextStyle sendersMessageStyle;

  /// TextStyle for senders chat message time
  final TextStyle sendersMessageTimeStyle;

  /// Background color for senders Message bubble
  final Color sendersMessageBackgroundColor;

  // /// Background color for chat screen
  // final Color chatBackgroundColor;

  /// send Icon color
  final Widget sendIcon;

  /// Attachment Icon on chat screen
  final Widget attachmentIcon;

  // /// Background color for chat screen input field
  // final Color inputFieldBackgroundColor;

  // /// Foreground color for chat screen input field
  // final Color inputFieldForegroundColor;

  // /// TextStyle for chat screen input field
  // final TextStyle inputFieldTextStyle;

  /// Background color for date separator on chat screen
  final Color dateSeparatorBackgroundColor;

  /// TextStyle for date separator on chat screen
  final TextStyle dateSeparatorTextStyle;

  // /// background color for go to bottom button
  // final Color goToBottomButtonBackgroundColor;

  // /// Icon for go to bottom button
  // final Widget goToBottomButtonIcon;

  // /// Background color for chat tile
  // final Color chatTileBackgroundColor;

  // /// TextStyle for chat tile name
  // final TextStyle chatTileNameStyle;

  // /// TextStyle for chat tile last message
  // final TextStyle chatTileLastMessageStyle;

  // /// TextStyle for chat tile time
  // final TextStyle chatTileTimeStyle;

  // /// Background color for chat tile unread message count
  // final Color chatTileUnreadMessageCountBackgroundColor;

  // /// TextStyle for chat tile unread message count
  // final TextStyle chatTileUnreadMessageCountTextStyle;

  // /// Offline Icon color for chat tile
  // final Color offlineIconColor;

  // /// Online Icon color for chat tile
  // final Color onlineIconColor;

  const ChatTheme({
    this.appBarBackgroundColor,
    this.appBarForegroundColor,
    required this.appbarNameStyle,
    required this.appBarOnlineStyle,
    required this.appBarTypingTextStyle,
    required this.lastSeenStyle,
    required this.recieverMessageStyle,
    required this.recieverMessageTimeStyle,
    required this.recieverMessageBackgroundColor,
    required this.sendersMessageStyle,
    required this.sendersMessageTimeStyle,
    required this.sendersMessageBackgroundColor,
    // required this.chatBackgroundColor,
    required this.sendIcon,
    required this.attachmentIcon,
    // required this.inputFieldBackgroundColor,
    // required this.inputFieldForegroundColor,
    // required this.inputFieldTextStyle,
    required this.dateSeparatorBackgroundColor,
    required this.dateSeparatorTextStyle,
    // required this.goToBottomButtonBackgroundColor,
    // required this.goToBottomButtonIcon,
    // required this.chatTileBackgroundColor,
    // required this.chatTileNameStyle,
    // required this.chatTileLastMessageStyle,
    // required this.chatTileTimeStyle,
    // required this.chatTileUnreadMessageCountBackgroundColor,
    // required this.chatTileUnreadMessageCountTextStyle,
    // required this.offlineIconColor,
    // required this.onlineIconColor,
  });
}

const TextStyle bodySmall =
    TextStyle(fontSize: 12, height: 1.5, wordSpacing: 0.4);
TextStyle bodyMedium =
    const TextStyle(fontSize: 14, height: 1.5, wordSpacing: 0.25);
const TextStyle bodyLarge =
    TextStyle(fontSize: 16, height: 1.5, wordSpacing: 0.15);

/// Default chat theme which extends [ChatTheme].
@immutable
class DefaultChatTheme extends ChatTheme {
  /// Creates a default chat theme. Use this constructor if you want to
  /// override only a couple of properties, otherwise create a new class
  /// which extends [ChatTheme]

  const DefaultChatTheme({
    super.appBarBackgroundColor,
    super.appBarForegroundColor,
    super.appbarNameStyle = const TextStyle(
        fontSize: 18, height: 1.5, wordSpacing: 0.15, color: Colors.white),
    super.appBarTypingTextStyle = const TextStyle(
        fontSize: 12, height: 1.5, wordSpacing: 0.4, color: Colors.white),
    super.appBarOnlineStyle = const TextStyle(
        fontSize: 12, height: 1.5, wordSpacing: 0.4, color: Colors.white),
    super.lastSeenStyle = const TextStyle(
        fontSize: 12, height: 1.5, wordSpacing: 0.4, color: Colors.white),
    super.dateSeparatorTextStyle =
        const TextStyle(fontSize: 11.0, color: Colors.black),
    super.dateSeparatorBackgroundColor =
        const Color.fromRGBO(212, 234, 244, 1.0),
    super.sendersMessageBackgroundColor = const Color(0xffe9ffd9),
    super.recieverMessageBackgroundColor = Colors.white,
    super.sendersMessageStyle = const TextStyle(
        fontSize: 14, height: 1.5, wordSpacing: 0.25, color: Colors.black),
    super.recieverMessageStyle = const TextStyle(
        fontSize: 14, height: 1.5, wordSpacing: 0.25, color: Colors.black),
    super.sendersMessageTimeStyle = const TextStyle(
        color: Color(0xff424242), fontSize: 10.0, fontStyle: FontStyle.italic),
    super.recieverMessageTimeStyle = const TextStyle(
        color: Color(0xff424242), fontSize: 10.0, fontStyle: FontStyle.italic),
    super.sendIcon = const Padding(
      padding: EdgeInsets.only(left: 3),
      child: Icon(
        Icons.check,
        size: 12,
        color: Colors.blueAccent,
      ),
    ),
    super.attachmentIcon = const _AttachIcon(),
  }) : super();
}

class _AttachIcon extends StatelessWidget {
  const _AttachIcon();

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: 50 * 3.1415926535897932 / 180,
        child: const Icon(
          Icons.attachment,
          color: Colors.white,
        ));
  }
}
