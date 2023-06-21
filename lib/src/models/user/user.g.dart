// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      createdAt: DateTime.parse(json['createdAt'] as String),
      fcmTokens: (json['fcmTokens'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      lastSeen: DateTime.parse(json['lastSeen'] as String),
      id: json['id'] as String,
      isActive: json['isActive'] as bool? ?? false,
      typingGroup: json['typingGroup'] as String?,
      name: json['name'] as String?,
      profilePic: json['profilePic'] as String?,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'createdAt': instance.createdAt.toIso8601String(),
      'fcmTokens': instance.fcmTokens,
      'lastSeen': instance.lastSeen.toIso8601String(),
      'id': instance.id,
      'isActive': instance.isActive,
      'typingGroup': instance.typingGroup,
      'name': instance.name,
      'profilePic': instance.profilePic,
      'data': instance.data,
    };
