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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// number of new messages which are not read by recepient user
  int get unreadMessageCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      DateTime timestamp,
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastMessage = freezed,
    Object? data = freezed,
    Object? users = null,
    Object? timestamp = null,
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
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      unreadMessageCount: null == unreadMessageCount
          ? _value.unreadMessageCount
          : unreadMessageCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

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
abstract class _$$_GroupCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$$_GroupCopyWith(_$_Group value, $Res Function(_$_Group) then) =
      __$$_GroupCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      Message? lastMessage,
      Map<String, dynamic>? data,
      List<String> users,
      DateTime timestamp,
      int unreadMessageCount});

  @override
  $MessageCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$_GroupCopyWithImpl<$Res> extends _$GroupCopyWithImpl<$Res, _$_Group>
    implements _$$_GroupCopyWith<$Res> {
  __$$_GroupCopyWithImpl(_$_Group _value, $Res Function(_$_Group) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? lastMessage = freezed,
    Object? data = freezed,
    Object? users = null,
    Object? timestamp = null,
    Object? unreadMessageCount = null,
  }) {
    return _then(_$_Group(
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
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      unreadMessageCount: null == unreadMessageCount
          ? _value.unreadMessageCount
          : unreadMessageCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Group implements _Group {
  _$_Group(
      {required this.id,
      this.lastMessage,
      final Map<String, dynamic>? data,
      final List<String> users = const [],
      required this.timestamp,
      this.unreadMessageCount = 0})
      : _data = data,
        _users = users;

  factory _$_Group.fromJson(Map<String, dynamic> json) =>
      _$$_GroupFromJson(json);

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
  @JsonKey()
  List<String> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  /// timetamp when group is created or when new message is sent
  @override
  final DateTime timestamp;

  /// number of new messages which are not read by recepient user
  @override
  @JsonKey()
  final int unreadMessageCount;

  @override
  String toString() {
    return 'Group(id: $id, lastMessage: $lastMessage, data: $data, users: $users, timestamp: $timestamp, unreadMessageCount: $unreadMessageCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Group &&
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

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      lastMessage,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(_users),
      timestamp,
      unreadMessageCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GroupCopyWith<_$_Group> get copyWith =>
      __$$_GroupCopyWithImpl<_$_Group>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupToJson(
      this,
    );
  }
}

abstract class _Group implements Group {
  factory _Group(
      {required final String id,
      final Message? lastMessage,
      final Map<String, dynamic>? data,
      final List<String> users,
      required final DateTime timestamp,
      final int unreadMessageCount}) = _$_Group;

  factory _Group.fromJson(Map<String, dynamic> json) = _$_Group.fromJson;

  @override

  /// unique id of the group
  String get id;
  @override

  /// last message which is sent by any of the users in group
  Message? get lastMessage;
  @override

  /// custom data which you want to save in the group
  Map<String, dynamic>? get data;
  @override

  /// list of users in the group
  List<String> get users;
  @override

  /// timetamp when group is created or when new message is sent
  DateTime get timestamp;
  @override

  /// number of new messages which are not read by recepient user
  int get unreadMessageCount;
  @override
  @JsonKey(ignore: true)
  _$$_GroupCopyWith<_$_Group> get copyWith =>
      throw _privateConstructorUsedError;
}
