// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Group _$GroupFromJson(Map<String, dynamic> json) {
  return _Group.fromJson(json);
}

/// @nodoc
mixin _$Group {
  /// unique id of the group
  String get id => throw _privateConstructorUsedError;

  /// last message which is sent by any of the users in group
  Message? get lastMessage => throw _privateConstructorUsedError;

  /// custom data which you want to save in the group
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;

  /// list of users in the group
  List<String> get users => throw _privateConstructorUsedError;

  /// timetamp when group is created or when new message is sent
  String? get timestamp => throw _privateConstructorUsedError;

  /// number of new messages which are not read by recepient user
  int get unreadMessageCount => throw _privateConstructorUsedError;

  /// Serializes this Group to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroupCopyWith<Group> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupCopyWith<$Res> {
  factory $GroupCopyWith(Group value, $Res Function(Group) then) =
      _$GroupCopyWithImpl<$Res, Group>;
  @useResult
  $Res call(
      {String id,
      Message? lastMessage,
      Map<String, dynamic>? data,
      List<String> users,
      String? timestamp,
      int unreadMessageCount});

  $MessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$GroupCopyWithImpl<$Res, $Val extends Group>
    implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastMessage = freezed,
    Object? data = freezed,
    Object? users = null,
    Object? timestamp = freezed,
    Object? unreadMessageCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as Message?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
      unreadMessageCount: null == unreadMessageCount
          ? _value.unreadMessageCount
          : unreadMessageCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $MessageCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GroupImplCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$$GroupImplCopyWith(
          _$GroupImpl value, $Res Function(_$GroupImpl) then) =
      __$$GroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Message? lastMessage,
      Map<String, dynamic>? data,
      List<String> users,
      String? timestamp,
      int unreadMessageCount});

  @override
  $MessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$GroupImplCopyWithImpl<$Res>
    extends _$GroupCopyWithImpl<$Res, _$GroupImpl>
    implements _$$GroupImplCopyWith<$Res> {
  __$$GroupImplCopyWithImpl(
      _$GroupImpl _value, $Res Function(_$GroupImpl) _then)
      : super(_value, _then);

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastMessage = freezed,
    Object? data = freezed,
    Object? users = null,
    Object? timestamp = freezed,
    Object? unreadMessageCount = null,
  }) {
    return _then(_$GroupImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as Message?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String?,
      unreadMessageCount: null == unreadMessageCount
          ? _value.unreadMessageCount
          : unreadMessageCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupImpl implements _Group {
  _$GroupImpl(
      {required this.id,
      this.lastMessage,
      final Map<String, dynamic>? data,
      required final List<String> users,
      this.timestamp,
      this.unreadMessageCount = 0})
      : _data = data,
        _users = users;

  factory _$GroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupImplFromJson(json);

  /// unique id of the group
  @override
  final String id;

  /// last message which is sent by any of the users in group
  @override
  final Message? lastMessage;

  /// custom data which you want to save in the group
  final Map<String, dynamic>? _data;

  /// custom data which you want to save in the group
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  /// list of users in the group
  final List<String> _users;

  /// list of users in the group
  @override
  List<String> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  /// timetamp when group is created or when new message is sent
  @override
  final String? timestamp;

  /// number of new messages which are not read by recepient user
  @override
  @JsonKey()
  final int unreadMessageCount;

  @override
  String toString() {
    return 'Group(id: $id, lastMessage: $lastMessage, data: $data, users: $users, timestamp: $timestamp, unreadMessageCount: $unreadMessageCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.unreadMessageCount, unreadMessageCount) ||
                other.unreadMessageCount == unreadMessageCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      lastMessage,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(_users),
      timestamp,
      unreadMessageCount);

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      __$$GroupImplCopyWithImpl<_$GroupImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupImplToJson(
      this,
    );
  }
}

abstract class _Group implements Group {
  factory _Group(
      {required final String id,
      final Message? lastMessage,
      final Map<String, dynamic>? data,
      required final List<String> users,
      final String? timestamp,
      final int unreadMessageCount}) = _$GroupImpl;

  factory _Group.fromJson(Map<String, dynamic> json) = _$GroupImpl.fromJson;

  /// unique id of the group
  @override
  String get id;

  /// last message which is sent by any of the users in group
  @override
  Message? get lastMessage;

  /// custom data which you want to save in the group
  @override
  Map<String, dynamic>? get data;

  /// list of users in the group
  @override
  List<String> get users;

  /// timetamp when group is created or when new message is sent
  @override
  String? get timestamp;

  /// number of new messages which are not read by recepient user
  @override
  int get unreadMessageCount;

  /// Create a copy of Group
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroupImplCopyWith<_$GroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
