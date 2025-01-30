// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  /// content of sent message
  /// text in case of [MessageType.text]
  /// image url in case of [MessageType.image]
  /// lat lng in case of [MessageType.location]
  String get content => throw _privateConstructorUsedError;

  /// user which sends this message
  String get idFrom => throw _privateConstructorUsedError;

  /// user who receives this message
  String get idTo => throw _privateConstructorUsedError;

  /// time when this message is sent
  String get timestamp => throw _privateConstructorUsedError;

  /// type of the message
  MessageType get type => throw _privateConstructorUsedError;

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {String content,
      String idFrom,
      String idTo,
      String timestamp,
      MessageType type});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? idFrom = null,
    Object? idTo = null,
    Object? timestamp = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      idFrom: null == idFrom
          ? _value.idFrom
          : idFrom // ignore: cast_nullable_to_non_nullable
              as String,
      idTo: null == idTo
          ? _value.idTo
          : idTo // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String content,
      String idFrom,
      String idTo,
      String timestamp,
      MessageType type});
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? idFrom = null,
    Object? idTo = null,
    Object? timestamp = null,
    Object? type = null,
  }) {
    return _then(_$MessageImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      idFrom: null == idFrom
          ? _value.idFrom
          : idFrom // ignore: cast_nullable_to_non_nullable
              as String,
      idTo: null == idTo
          ? _value.idTo
          : idTo // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl implements _Message {
  _$MessageImpl(
      {required this.content,
      required this.idFrom,
      required this.idTo,
      required this.timestamp,
      this.type = MessageType.text});

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  /// content of sent message
  /// text in case of [MessageType.text]
  /// image url in case of [MessageType.image]
  /// lat lng in case of [MessageType.location]
  @override
  final String content;

  /// user which sends this message
  @override
  final String idFrom;

  /// user who receives this message
  @override
  final String idTo;

  /// time when this message is sent
  @override
  final String timestamp;

  /// type of the message
  @override
  @JsonKey()
  final MessageType type;

  @override
  String toString() {
    return 'Message(content: $content, idFrom: $idFrom, idTo: $idTo, timestamp: $timestamp, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.idFrom, idFrom) || other.idFrom == idFrom) &&
            (identical(other.idTo, idTo) || other.idTo == idTo) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, content, idFrom, idTo, timestamp, type);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  factory _Message(
      {required final String content,
      required final String idFrom,
      required final String idTo,
      required final String timestamp,
      final MessageType type}) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  /// content of sent message
  /// text in case of [MessageType.text]
  /// image url in case of [MessageType.image]
  /// lat lng in case of [MessageType.location]
  @override
  String get content;

  /// user which sends this message
  @override
  String get idFrom;

  /// user who receives this message
  @override
  String get idTo;

  /// time when this message is sent
  @override
  String get timestamp;

  /// type of the message
  @override
  MessageType get type;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
