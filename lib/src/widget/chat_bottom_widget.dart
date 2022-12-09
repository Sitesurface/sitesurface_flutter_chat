import 'package:flutter/material.dart';
import 'package:sitesurface_flutter_chat/src/utils/theme/inherited_chat_theme.dart';
import 'circle_icon_button.dart';

class ChatBottomWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final void Function(String text)? onSendTapped;
  final void Function()? onCameraTapped;
  final void Function()? onGalleryTapped;
  final void Function(BuildContext context)? onLocationTapped;
  const ChatBottomWidget({
    Key? key,
    this.onSendTapped,
    this.onCameraTapped,
    this.onGalleryTapped,
    this.onLocationTapped,
    required this.textEditingController,
  }) : super(key: key);

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
    var brightness = Theme.of(context).brightness;
    var theme = InheritedChatTheme.of(context).theme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Flexible(
                child: TextField(
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
                hintText: "Message",
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
                        builder: (context) {
                          return Container(
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
                                      color: Colors.redAccent,
                                      onTap: widget.onCameraTapped,
                                      iconData: Icons.photo_camera,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text("Camera"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleIconButton(
                                      color: Colors.purpleAccent,
                                      onTap: widget.onGalleryTapped,
                                      iconData: Icons.photo,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text("Gallery"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleIconButton(
                                      color: Colors.lightGreen,
                                      onTap: () {
                                        if (widget.onLocationTapped == null) {
                                          return;
                                        }
                                        widget.onLocationTapped!(context);
                                      },
                                      iconData: Icons.place,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text("Location"),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
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
      ),
    );
  }
}
