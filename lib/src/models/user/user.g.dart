// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      createdAt: json['createdAt'] as String?,
      fcmTokens: (json['fcmTokens'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      lastSeen: json['lastSeen'] as String?,
      id: json['id'] as String,
      isActive: json['isActive'] as bool? ?? false,
      typingGroup: json['typingGroup'] as String?,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'fcmTokens': instance.fcmTokens,
      'lastSeen': instance.lastSeen,
      'id': instance.id,
      'isActive': instance.isActive,
      'typingGroup': instance.typingGroup,
      'data': instance.data,
    };
