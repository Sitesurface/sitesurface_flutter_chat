import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../sitesurface_flutter_chat.dart';
import '../utils/datetime_utils.dart';
import '../utils/locale/inherited_chat_locale.dart';
import '../utils/theme/inherited_chat_theme.dart';
import 'chat_bubble/chat_bubble.dart';

class MessageItem extends StatelessWidget {
  final int index;
  final Message message;
  final String? currUserId;
  final BuildContext context;
  final List<Message> listMessage;
  final void Function(String url)? openMap;

  const MessageItem(
      {super.key,
      required this.index,
      required this.message,
      required this.currUserId,
      required this.context,
      required this.listMessage,
      this.openMap});

  @override
  Widget build(BuildContext context) {
    bool isNewMsg(int index) {
      if (index == (listMessage.length - 1)) {
        return false;
      }
      final curr = DateTime.fromMillisecondsSinceEpoch(
          int.parse(listMessage[index].timestamp));
      final prev = DateTime.fromMillisecondsSinceEpoch(
          int.parse(listMessage[index + 1].timestamp));
      if (curr.year == prev.year &&
          curr.month == prev.month &&
          curr.day == prev.day) {
        return false;
      } else {
        return true;
      }
    }

    final theme = InheritedChatTheme.of(context).theme;

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isNewMsg(index))
            Bubble(
              margin: const BubbleEdges.only(top: 20, bottom: 20),
              alignment: Alignment.center,
              color: theme.dateSeparatorBackgroundColor,
              child: Text(() {
                final separatorDate = DateTime.fromMillisecondsSinceEpoch(
                    int.parse(message.timestamp));
                return dateSeparatorFormat(separatorDate, context);
              }(),
                  textAlign: TextAlign.center,
                  style: theme.dateSeparatorTextStyle),
            ),
          () {
            switch (message.type) {
              case MessageType.text:
                return _TextMessageWidget(
                  isSender: currUserId == message.idFrom,
                  message: message,
                  showNip: showNib(index),
                );
              case MessageType.image:
                return _ImageWidget(
                  message: message,
                  isSender: currUserId == message.idFrom,
                  showNip: showNib(index),
                );
              case MessageType.location:
                return _LocationWidget(
                  message: message,
                  isSender: currUserId == message.idFrom,
                  showNip: showNib(index),
                );
            }
          }(),
        ],
      ),
    );
  }

  bool showNib(int index) {
    if (index == listMessage.length - 1) return true;
    if (message.idFrom == listMessage[index + 1].idFrom) {
      return false;
    } else {
      return true;
    }
  }
}

class _TextMessageWidget extends StatelessWidget {
  final bool showNip;
  final bool isSender;
  const _TextMessageWidget({
    required this.message,
    required this.showNip,
    required this.isSender,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    final theme = InheritedChatTheme.of(context).theme;

    return Column(
      crossAxisAlignment:
          isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: !showNip
              ? EdgeInsets.only(left: isSender ? 0 : 6, right: isSender ? 6 : 0)
              : EdgeInsets.zero,
          child: Bubble(
            showNip: true,
            nip: showNip
                ? isSender
                    ? BubbleNip.rightTop
                    : BubbleNip.leftTop
                : null,
            padding: const BubbleEdges.all(10),
            margin: const BubbleEdges.only(top: 5),
            alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
            color: isSender
                ? theme.sendersMessageBackgroundColor
                : theme.recieverMessageBackgroundColor,
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              child: Wrap(
                runSpacing: 5,
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  Text(
                    message.content,
                    style: isSender
                        ? theme.sendersMessageStyle
                        : theme.recieverMessageStyle,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat('hh:mm aa').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                int.parse(message.timestamp))),
                        style: isSender
                            ? theme.sendersMessageTimeStyle
                            : theme.recieverMessageTimeStyle,
                      ),
                      if (isSender) theme.sendIcon
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LocationWidget extends StatelessWidget {
  final Message message;
  final bool isSender;
  final bool showNip;
  final void Function(String url)? onTap;
  const _LocationWidget({
    required this.message,
    required this.isSender,
    required this.showNip,
    // ignore: unused_element
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final mapUri = Uri(
      scheme: 'https',
      host: 'maps.googleapis.com',
      path: 'maps/api/staticmap',
      queryParameters: {
        'center': message.content,
        'zoom': '18',
        'size': '400x400',
        'markers': 'size:mid|color:0xFF7717|${message.content}',
        'key': 'AIzaSyBD-EvQTcV3m73xrrWbDjUiEubDeSIIX-o'
      },
    );
    final url = mapUri.toString();
    final theme = InheritedChatTheme.of(context).theme;
    final l10n = InheritedL10n.of(context).l10n;
    return Padding(
      padding: !showNip
          ? EdgeInsets.only(left: isSender ? 0 : 6, right: isSender ? 6 : 0)
          : EdgeInsets.zero,
      child: Bubble(
        showNip: true,
        nip: showNip
            ? isSender
                ? BubbleNip.rightTop
                : BubbleNip.leftTop
            : null,
        padding: const BubbleEdges.all(5),
        margin: const BubbleEdges.only(top: 5),
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        color: isSender
            ? theme.sendersMessageBackgroundColor
            : theme.recieverMessageBackgroundColor,
        child: InkWell(
          onTap: () {
            openMap(message.content);
          },
          child: Column(
            children: [
              Container(
                height: width * 0.4,
                width: width * 0.6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(url), fit: BoxFit.cover)),
                margin: const EdgeInsets.only(bottom: 10.0),
              ),
              SizedBox(
                width: width * 0.6,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(l10n.sharedLocationLabel,
                          style: isSender
                              ? theme.sendersMessageStyle
                              : theme.recieverMessageStyle),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat('hh:mm aa').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(message.timestamp))),
                            style: isSender
                                ? theme.sendersMessageTimeStyle
                                : theme.recieverMessageTimeStyle,
                          ),
                          if (isSender) theme.sendIcon
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openMap(String latlng) async {
    final googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latlng';
    if (onTap != null) {
      onTap!(googleUrl);
    }
  }
}

class _ImageWidget extends StatelessWidget {
  final bool isSender;
  final bool showNip;
  final Message message;
  const _ImageWidget(
      {required this.message, required this.isSender, required this.showNip});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = InheritedChatTheme.of(context).theme;
    return Padding(
      padding: !showNip
          ? EdgeInsets.only(left: isSender ? 0 : 6, right: isSender ? 6 : 0)
          : EdgeInsets.zero,
      child: Bubble(
        showNip: true,
        nip: showNip
            ? isSender
                ? BubbleNip.rightTop
                : BubbleNip.leftTop
            : null,
        padding: const BubbleEdges.all(5),
        margin: const BubbleEdges.only(top: 5),
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        color: isSender
            ? theme.sendersMessageBackgroundColor
            : theme.recieverMessageBackgroundColor,
        child: Stack(
          children: [
            Material(
              borderRadius: BorderRadius.circular(5.0),
              clipBehavior: Clip.hardEdge,
              child: isLink(message.content)
                  ? InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                backgroundColor: Colors.white,
                                appBar: AppBar(
                                  elevation: 0,
                                  leading: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                body: Center(
                                  child: InteractiveViewer(
                                    child: Image.network(message.content),
                                  ),
                                ),
                              ),
                            ));
                      },
                      child: Image.network(
                        message.content,
                        errorBuilder: (_, __, ___) => Container(),
                        width: width * 0.6,
                        height: width * 0.8,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox(
                        width: width * 0.6,
                        height: width * 0.8,
                        child: Image.file(
                          File(message.content),
                          fit: BoxFit.cover,
                          width: width * 0.6,
                          height: width * 0.8,
                        ),
                      ),
                    ),
            ),
            Positioned(
              right: 4,
              bottom: 4,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat('hh:mm aa').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            int.parse(message.timestamp))),
                    style: isSender
                        ? theme.sendersMessageTimeStyle
                        : theme.recieverMessageTimeStyle,
                  ),
                  if (isSender) theme.sendIcon
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // check if text is link
  bool isLink(String text) => text.contains('http');
}
