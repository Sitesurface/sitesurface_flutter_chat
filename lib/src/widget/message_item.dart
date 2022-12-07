import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitesurface_flutter_chat/src/enums/message_type.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../sitesurface_flutter_chat.dart';
import 'chat_bubble/chat_bubble.dart';

class MessageItem extends StatelessWidget {
  final int index;
  final Message message;
  final String? currUserId;
  final BuildContext context;
  final List<Message> listMessage;

  const MessageItem(
      {Key? key,
      required this.index,
      required this.message,
      required this.currUserId,
      required this.context,
      required this.listMessage})
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
      margin: const EdgeInsets.only(bottom: 10.0),
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
                  style: const TextStyle(fontSize: 11.0)),
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
                return _ImageWidget(message: message);
              case MessageType.location:
                return _LocationWidget(message: message);
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
  const _LocationWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mapUri = Uri(
      scheme: 'https',
      host: 'maps.googleapis.com',
      path: 'maps/api/staticmap',
      queryParameters: {
        "center": message.content,
        "zoom": "15",
        "size": "200x200",
        "markers": "size:mid|color:0xFF7717|${message.content}",
        "key": "AIzaSyBD-EvQTcV3m73xrrWbDjUiEubDeSIIX-o"
      },
    );
    var url = mapUri.toString();
    return InkWell(
      onTap: () {
        openMap(message.content);
      },
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(image: NetworkImage(url))),
        margin: const EdgeInsets.only(bottom: 10.0),
      ),
    );
  }

  Future<void> openMap(String latlng) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latlng';
    if (await canLaunchUrlString(googleUrl)) {
      await launchUrlString(googleUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not open the map.');
    }
  }
}

class _ImageWidget extends StatelessWidget {
  final Message message;
  const _ImageWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8.0),
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
                loadingBuilder: (_, __, ___) => const SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
                errorBuilder: (_, __, ___) => Container(),
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: 200,
                width: 200,
                child: Stack(
                  children: [
                    Image.file(
                      File(message.content),
                      fit: BoxFit.cover,
                      height: 200,
                      width: 200,
                    ),
                    const Center(child: CircularProgressIndicator.adaptive())
                  ],
                ),
              ),
            ),
    );
  }

  // check if text is link
  bool isLink(String text) {
    return text.contains("https");
  }
}
