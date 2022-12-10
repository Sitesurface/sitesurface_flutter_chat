import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitesurface_flutter_chat/src/utils/locale/inherited_chat_locale.dart';

import '../../sitesurface_flutter_chat.dart';

extension DateTimeUtils on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }
}

String lastSeenDateFormat(DateTime dateTime, BuildContext context) {
  try {
    var l10n = InheritedL10n.of(context).l10n;
    String output = DateFormat("dd MMMM").format(dateTime);
    if (dateTime.isToday()) {
      output = l10n.todayLabel.toLowerCase();
    } else if (dateTime.isYesterday()) {
      output = l10n.yesterdayLabel.toLowerCase();
    }
    return output;
  } catch (e) {
    debugPrint(e.toString());
    return "";
  }
}

String dateSeparatorFormat(DateTime dateTime, BuildContext context) {
  try {
    var l10n = InheritedL10n.of(context).l10n;
    String output = DateFormat("dd MMMM y").format(dateTime);
    if (dateTime.isToday()) {
      output = l10n.todayLabel;
    } else if (dateTime.isYesterday()) {
      output = l10n.yesterdayLabel;
    }
    return output;
  } catch (e) {
    debugPrint(e.toString());
    return "";
  }
}

String chatWidgetDateFormat(DateTime dateTime, ChatL10n l10n) {
  try {
    String output = DateFormat("dd/MM/yy").format(dateTime);
    if (dateTime.isToday()) {
      output = DateFormat("hh:mm aa").format(dateTime);
    } else if (dateTime.isYesterday()) {
      output = l10n.yesterdayLabel[0].toUpperCase() +
          l10n.yesterdayLabel.substring(1).toLowerCase();
    }
    return output;
  } catch (e) {
    debugPrint(e.toString());
    return "";
  }
}
