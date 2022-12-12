import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../sitesurface_flutter_chat.dart';
import '../utils/datetime_utils.dart';
import '../utils/locale/inherited_chat_locale.dart';
import '../utils/theme/inherited_chat_theme.dart';

/// Default app bar which is displayed in chatting page. You can override [chatAppbarBuilder] in [ChatDelegate] and
/// return [SfcAppBar] with your own custom [actions].
class SfcAppBar extends StatelessWidget {
  final List<Widget> actions;

  /// recepient user
  final User? user;

  /// whether recepient user is currently typing or not
  final bool isTyping;
  const SfcAppBar(
      {super.key, required this.actions, this.user, required this.isTyping});

  @override
  Widget build(BuildContext context) {
    final theme = InheritedChatTheme.of(context).theme;
    final l10n = InheritedL10n.of(context).l10n;
    return AppBar(
      actions: actions,
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
                  backgroundImage: NetworkImage(user?.profilePic ?? ""),
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
                        user?.name ?? "",
                        style: theme.appbarNameStyle,
                      ),
                      () {
                        if (isTyping) {
                          return Text(
                            l10n.typingLabel,
                            style: theme.appBarTypingTextStyle,
                          );
                        } else if (user?.isActive ?? false) {
                          return Text(l10n.onlineLabel,
                              style: theme.appBarOnlineStyle);
                        } else {
                          var lastSeenDate =
                              DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(user?.lastSeen ?? ""));
                          var lastSeen =
                              "${l10n.lastSeenLabel} ${lastSeenDateFormat(lastSeenDate, context)}, ${DateFormat("hh:mm aa").format(lastSeenDate)}";
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
}
