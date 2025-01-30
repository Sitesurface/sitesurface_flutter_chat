// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  /// Time when user is created
  String? get createdAt => throw _privateConstructorUsedError;

  /// active fcm tokens of user for sending notification
  List<String> get fcmTokens => throw _privateConstructorUsedError;

  /// time when user was last active
  String? get lastSeen => throw _privateConstructorUsedError;

  /// unique id of user
  String get id => throw _privateConstructorUsedError;

  /// bool for saving if user is currently active or not
  bool get isActive => throw _privateConstructorUsedError;

  /// the current group  in which user is typing message
  String? get typingGroup => throw _privateConstructorUsedError;

  /// name of user
  String? get name => throw _privateConstructorUsedError;

  /// profile pic url of user
  String? get profilePic => throw _privateConstructorUsedError;

  /// custom data of user which you want to save in db
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String? createdAt,
      List<String> fcmTokens,
      String? lastSeen,
      String id,
      bool isActive,
      String? typingGroup,
      String? name,
      String? profilePic,
      Map<String, dynamic>? data});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? fcmTokens = null,
    Object? lastSeen = freezed,
    Object? id = null,
    Object? isActive = null,
    Object? typingGroup = freezed,
    Object? name = freezed,
    Object? profilePic = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmTokens: null == fcmTokens
          ? _value.fcmTokens
          : fcmTokens // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as String?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      typingGroup: freezed == typingGroup
          ? _value.typingGroup
          : typingGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePic: freezed == profilePic
          ? _value.profilePic
          : profilePic // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? createdAt,
      List<String> fcmTokens,
      String? lastSeen,
      String id,
      bool isActive,
      String? typingGroup,
      String? name,
      String? profilePic,
      Map<String, dynamic>? data});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? fcmTokens = null,
    Object? lastSeen = freezed,
    Object? id = null,
    Object? isActive = null,
    Object? typingGroup = freezed,
    Object? name = freezed,
    Object? profilePic = freezed,
    Object? data = freezed,
  }) {
    return _then(_$UserImpl(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmTokens: null == fcmTokens
          ? _value._fcmTokens
          : fcmTokens // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as String?,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      typingGroup: freezed == typingGroup
          ? _value.typingGroup
          : typingGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePic: freezed == profilePic
          ? _value.profilePic
          : profilePic // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  _$UserImpl(
      {this.createdAt,
      final List<String> fcmTokens = const [],
      this.lastSeen,
      required this.id,
      this.isActive = false,
      this.typingGroup,
      this.name,
      this.profilePic,
      final Map<String, dynamic>? data})
      : _fcmTokens = fcmTokens,
        _data = data;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  /// Time when user is created
  @override
  final String? createdAt;

  /// active fcm tokens of user for sending notification
  final List<String> _fcmTokens;

  /// active fcm tokens of user for sending notification
  @override
  @JsonKey()
  List<String> get fcmTokens {
    if (_fcmTokens is EqualUnmodifiableListView) return _fcmTokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fcmTokens);
  }

  /// time when user was last active
  @override
  final String? lastSeen;

  /// unique id of user
  @override
  final String id;

  /// bool for saving if user is currently active or not
  @override
  @JsonKey()
  final bool isActive;

  /// the current group  in which user is typing message
  @override
  final String? typingGroup;

  /// name of user
  @override
  final String? name;

  /// profile pic url of user
  @override
  final String? profilePic;

  /// custom data of user which you want to save in db
  final Map<String, dynamic>? _data;

  /// custom data of user which you want to save in db
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'User(createdAt: $createdAt, fcmTokens: $fcmTokens, lastSeen: $lastSeen, id: $id, isActive: $isActive, typingGroup: $typingGroup, name: $name, profilePic: $profilePic, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._fcmTokens, _fcmTokens) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.typingGroup, typingGroup) ||
                other.typingGroup == typingGroup) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profilePic, profilePic) ||
                other.profilePic == profilePic) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      createdAt,
      const DeepCollectionEquality().hash(_fcmTokens),
      lastSeen,
      id,
      isActive,
      typingGroup,
      name,
      profilePic,
      const DeepCollectionEquality().hash(_data));

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  factory _User(
      {final String? createdAt,
      final List<String> fcmTokens,
      final String? lastSeen,
      required final String id,
      final bool isActive,
      final String? typingGroup,
      final String? name,
      final String? profilePic,
      final Map<String, dynamic>? data}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  /// Time when user is created
  @override
  String? get createdAt;

  /// active fcm tokens of user for sending notification
  @override
  List<String> get fcmTokens;

  /// time when user was last active
  @override
  String? get lastSeen;

  /// unique id of user
  @override
  String get id;

  /// bool for saving if user is currently active or not
  @override
  bool get isActive;

  /// the current group  in which user is typing message
  @override
  String? get typingGroup;

  /// name of user
  @override
  String? get name;

  /// profile pic url of user
  @override
  String? get profilePic;

  /// custom data of user which you want to save in db
  @override
  Map<String, dynamic>? get data;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
