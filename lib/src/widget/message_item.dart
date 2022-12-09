import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sitesurface_flutter_chat/src/enums/message_type.dart';

import '../../sitesurface_flutter_chat.dart';
import 'chat_bubble/chat_bubble.dart';

class MessageItem extends StatelessWidget {
  final int index;
  final Message message;
  final String? currUserId;
  final BuildContext context;
  final List<Message> listMessage;
  final void Function(String url)? openMap;

  const MessageItem(
      {Key? key,
      required this.index,
      required this.message,
      required this.currUserId,
      required this.context,
      required this.listMessage,
      this.openMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isNewMsg(int index) {
      if (index == (listMessage.length - 1)) {
        return true;
      }
      DateTime curr = DateTime.fromMillisecondsSinceEpoch(
          int.parse(listMessage[index].timestamp));
      DateTime prev = DateTime.fromMillisecondsSinceEpoch(
          int.parse(listMessage[index + 1].timestamp));
      if (curr.year == prev.year &&
          curr.month == prev.month &&
          curr.day == prev.day) {
        return false;
      } else {
        return true;
      }
    }

    bool isToday(int index) {
      DateTime today = DateTime.now();
      DateTime curr = DateTime.fromMillisecondsSinceEpoch(
          int.parse(listMessage[index].timestamp));
      if (curr.day == today.day) {
        return true;
      } else {
        return false;
      }
    }

    bool isYesterday(int index) {
      DateTime today = DateTime.now();
      DateTime curr = DateTime.fromMillisecondsSinceEpoch(
          int.parse(listMessage[index].timestamp));
      if (curr.day == (today.day - 1)) {
        return true;
      } else {
        return false;
      }
    }

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
              color: const Color.fromRGBO(212, 234, 244, 1.0),
              child: Text(
                  isToday(index)
                      ? "TODAY"
                      : isYesterday(index)
                          ? "YESTERDAY"
                          : DateFormat("dd MMMM yyy").format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(message.timestamp))),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11.0, color: Colors.black)),
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
    Key? key,
    required this.message,
    required this.showNip,
    required this.isSender,
  }) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment:
          isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: !showNip
              ? EdgeInsets.only(left: isSender ? 5 : 0, right: isSender ? 5 : 0)
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
            color: isSender ? const Color(0xffe9ffd9) : Colors.white,
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
                    style: textTheme.bodyMedium?.copyWith(color: Colors.black),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat("hh:mm aa").format(
                            DateTime.fromMillisecondsSinceEpoch(
                                int.parse(message.timestamp))),
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 10.0,
                            fontStyle: FontStyle.italic),
                      ),
                      if (isSender)
                        const Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Icon(
                            Icons.check,
                            size: 12,
                            color: Colors.blueAccent,
                          ),
                        )
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
    Key? key,
    required this.message,
    required this.isSender,
    required this.showNip,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var textTheme = Theme.of(context).textTheme;
    var mapUri = Uri(
      scheme: 'https',
      host: 'maps.googleapis.com',
      path: 'maps/api/staticmap',
      queryParameters: {
        "center": message.content,
        "zoom": "18",
        "size": "400x400",
        "markers": "size:mid|color:0xFF7717|${message.content}",
        "key": "AIzaSyBD-EvQTcV3m73xrrWbDjUiEubDeSIIX-o"
      },
    );
    var url = mapUri.toString();
    return Bubble(
      showNip: true,
      nip: showNip
          ? isSender
              ? BubbleNip.rightTop
              : BubbleNip.leftTop
          : null,
      padding: const BubbleEdges.all(5),
      margin: const BubbleEdges.only(top: 5),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      color: isSender ? const Color(0xffe9ffd9) : Colors.white,
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
                    Text("Shared location",
                        style: textTheme.bodyMedium
                            ?.copyWith(color: Colors.black)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat("hh:mm aa").format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  int.parse(message.timestamp))),
                          style: const TextStyle(
                              fontSize: 10.0, fontStyle: FontStyle.italic),
                        ),
                        if (isSender)
                          const Padding(
                            padding: EdgeInsets.only(left: 3),
                            child: Icon(
                              Icons.check,
                              size: 12,
                              color: Colors.blueAccent,
                            ),
                          )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> openMap(String latlng) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latlng';
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
    var width = MediaQuery.of(context).size.width;
    return Bubble(
      showNip: true,
      nip: showNip
          ? isSender
              ? BubbleNip.rightTop
              : BubbleNip.leftTop
          : null,
      padding: const BubbleEdges.all(5),
      margin: const BubbleEdges.only(top: 5),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      color: isSender ? const Color(0xffe9ffd9) : Colors.white,
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
                  DateFormat("hh:mm aa").format(
                      DateTime.fromMillisecondsSinceEpoch(
                          int.parse(message.timestamp))),
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 10.0,
                      fontStyle: FontStyle.italic),
                ),
                if (isSender)
                  const Padding(
                    padding: EdgeInsets.only(left: 3),
                    child: Icon(
                      Icons.check,
                      size: 12,
                      color: Colors.blueAccent,
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

  // check if text is link
  bool isLink(String text) {
    return text.contains("https");
  }
}
