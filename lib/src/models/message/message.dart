import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sitesurface_flutter_chat/src/enums/message_type.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  factory Message(
      {required final String content,
      required final String idFrom,
      required final String idTo,
      required final String timestamp,
      @Default(MessageType.text) final MessageType type}) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
