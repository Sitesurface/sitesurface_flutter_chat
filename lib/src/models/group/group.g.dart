// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupImpl _$$GroupImplFromJson(Map<String, dynamic> json) => _$GroupImpl(
      id: json['id'] as String,
      lastMessage: json['lastMessage'] == null
          ? null
          : Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
      data: json['data'] as Map<String, dynamic>?,
      users: (json['users'] as List<dynamic>).map((e) => e as String).toList(),
      timestamp: json['timestamp'] as String?,
      unreadMessageCount: (json['unreadMessageCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$GroupImplToJson(_$GroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lastMessage': instance.lastMessage?.toJson(),
      'data': instance.data,
      'users': instance.users,
      'timestamp': instance.timestamp,
      'unreadMessageCount': instance.unreadMessageCount,
    };
