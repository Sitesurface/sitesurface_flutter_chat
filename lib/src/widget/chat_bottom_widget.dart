import 'package:flutter/material.dart';

import '../utils/locale/inherited_chat_locale.dart';
import '../utils/theme/inherited_chat_theme.dart';
import 'circle_icon_button.dart';

class ChatBottomWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final void Function(String text)? onSendTapped;
  final void Function()? onCameraTapped;
  final void Function()? onGalleryTapped;
  final void Function(BuildContext context)? onLocationTapped;
  const ChatBottomWidget({
    super.key,
    this.onSendTapped,
    this.onCameraTapped,
    this.onGalleryTapped,
    this.onLocationTapped,
    required this.textEditingController,
  });

  @override
  State<ChatBottomWidget> createState() => _ChatBottomWidgetState();
}

class _ChatBottomWidgetState extends State<ChatBottomWidget> {
  late final TextEditingController textEditingController;
  bool isTextEmpty = true;

  @override
  void initState() {
    textEditingController = widget.textEditingController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final theme = InheritedChatTheme.of(context).theme;
    final l10n = InheritedL10n.of(context).l10n;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            maxLines: 5,
            minLines: 1,
            controller: textEditingController,
            onChanged: (value) {
              if (value.trim().isEmpty) {
                if (isTextEmpty) return;
                isTextEmpty = true;
              } else {
                if (!isTextEmpty) return;
                isTextEmpty = false;
              }
              setState(() {});
            },
            decoration: InputDecoration(
              hintText: l10n.messageInputHint,
              isDense: true,
              filled: true,
              fillColor: brightness == Brightness.light
                  ? Colors.white
                  : Colors.grey[800]!,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: brightness == Brightness.light
                        ? Colors.white
                        : Colors.grey[800]!),
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: brightness == Brightness.light
                        ? Colors.white
                        : Colors.grey[800]!),
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: brightness == Brightness.light
                        ? Colors.white
                        : Colors.grey[800]!),
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
            ),
          )),
          const SizedBox(
            width: 8,
          ),
          if (isTextEmpty)
            CircleIconButton(
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => Container(
                            height: 130,
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey[800]
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    CircleIconButton(
                                      color: theme.cameraIconBackgroundColor,
                                      onTap: widget.onCameraTapped,
                                      icon: theme.cameraIconIcon,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(l10n.cameraAttachmentLabel),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleIconButton(
                                      color: theme.galleryIconBackgroundColor,
                                      onTap: widget.onGalleryTapped,
                                      icon: theme.galleryIcon,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(l10n.galleryAttachmentLabel),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleIconButton(
                                        color:
                                            theme.locationIconBackgroundColor,
                                        onTap: () {
                                          if (widget.onLocationTapped == null) {
                                            return;
                                          }
                                          widget.onLocationTapped!(context);
                                        },
                                        icon: theme.locationIcon),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(l10n.locationAttachmentLabel),
                                  ],
                                )
                              ],
                            ),
                          ));
                },
                icon: theme.attachmentIcon)
          else
            CircleIconButton(
              onTap: () {
                if (widget.onSendTapped == null) return;
                widget.onSendTapped!(textEditingController.text);
                isTextEmpty = true;
                setState(() {});
              },
              iconData: Icons.send,
            )
        ],
      ),
    );
  }
}
