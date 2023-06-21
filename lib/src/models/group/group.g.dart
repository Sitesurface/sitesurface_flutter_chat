// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Group _$$_GroupFromJson(Map<String, dynamic> json) => _$_Group(
      id: json['id'] as String,
      lastMessage: json['lastMessage'] == null
          ? null
          : Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
      data: json['data'] as Map<String, dynamic>?,
      users:
          (json['users'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      timestamp: DateTime.parse(json['timestamp'] as String),
      unreadMessageCount: json['unreadMessageCount'] as int? ?? 0,
    );

Map<String, dynamic> _$$_GroupToJson(_$_Group instance) => <String, dynamic>{
      'id': instance.id,
      'lastMessage': instance.lastMessage?.toJson(),
      'data': instance.data,
      'users': instance.users,
      'timestamp': instance.timestamp.toIso8601String(),
      'unreadMessageCount': instance.unreadMessageCount,
    };
