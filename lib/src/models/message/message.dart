import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sitesurface_flutter_chat/src/enums/message_type.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed

/// Object of message which is sent by user. All types of messages(text,location,image) are saved in this object only.
class Message with _$Message {
  factory Message(
      {

      /// content of sent message
      /// text in case of [MessageType.text]
      /// image url in case of [MessageType.image]
      /// lat lng in case of [MessageType.location]
      required final String content,

      /// user which sends this message
      required final String idFrom,

      /// user who receives this message
      required final String idTo,

      /// time when this message is sent
      required final String timestamp,

      /// type of the message
      @Default(MessageType.text) final MessageType type}) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
