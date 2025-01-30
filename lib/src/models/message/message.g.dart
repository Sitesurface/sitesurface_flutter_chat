// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      content: json['content'] as String,
      idFrom: json['idFrom'] as String,
      idTo: json['idTo'] as String,
      timestamp: json['timestamp'] as String,
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']) ??
          MessageType.text,
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'content': instance.content,
      'idFrom': instance.idFrom,
      'idTo': instance.idTo,
      'timestamp': instance.timestamp,
      'type': _$MessageTypeEnumMap[instance.type]!,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.location: 'location',
};
