// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'latlng.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SfcLatLng _$SfcLatLngFromJson(Map<String, dynamic> json) {
  return _SfcLatLng.fromJson(json);
}

/// @nodoc
mixin _$SfcLatLng {
  /// latitude of user
  double get latitude => throw _privateConstructorUsedError;

  /// longitude of user
  double get longitude => throw _privateConstructorUsedError;

  /// Serializes this SfcLatLng to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SfcLatLng
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SfcLatLngCopyWith<SfcLatLng> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SfcLatLngCopyWith<$Res> {
  factory $SfcLatLngCopyWith(SfcLatLng value, $Res Function(SfcLatLng) then) =
      _$SfcLatLngCopyWithImpl<$Res, SfcLatLng>;
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class _$SfcLatLngCopyWithImpl<$Res, $Val extends SfcLatLng>
    implements $SfcLatLngCopyWith<$Res> {
  _$SfcLatLngCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SfcLatLng
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SfcLatLngImplCopyWith<$Res>
    implements $SfcLatLngCopyWith<$Res> {
  factory _$$SfcLatLngImplCopyWith(
          _$SfcLatLngImpl value, $Res Function(_$SfcLatLngImpl) then) =
      __$$SfcLatLngImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$$SfcLatLngImplCopyWithImpl<$Res>
    extends _$SfcLatLngCopyWithImpl<$Res, _$SfcLatLngImpl>
    implements _$$SfcLatLngImplCopyWith<$Res> {
  __$$SfcLatLngImplCopyWithImpl(
      _$SfcLatLngImpl _value, $Res Function(_$SfcLatLngImpl) _then)
      : super(_value, _then);

  /// Create a copy of SfcLatLng
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$SfcLatLngImpl(
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SfcLatLngImpl implements _SfcLatLng {
  _$SfcLatLngImpl({required this.latitude, required this.longitude});

  factory _$SfcLatLngImpl.fromJson(Map<String, dynamic> json) =>
      _$$SfcLatLngImplFromJson(json);

  /// latitude of user
  @override
  final double latitude;

  /// longitude of user
  @override
  final double longitude;

  @override
  String toString() {
    return 'SfcLatLng(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SfcLatLngImpl &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  /// Create a copy of SfcLatLng
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SfcLatLngImplCopyWith<_$SfcLatLngImpl> get copyWith =>
      __$$SfcLatLngImplCopyWithImpl<_$SfcLatLngImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SfcLatLngImplToJson(
      this,
    );
  }
}

abstract class _SfcLatLng implements SfcLatLng {
  factory _SfcLatLng(
      {required final double latitude,
      required final double longitude}) = _$SfcLatLngImpl;

  factory _SfcLatLng.fromJson(Map<String, dynamic> json) =
      _$SfcLatLngImpl.fromJson;

  /// latitude of user
  @override
  double get latitude;

  /// longitude of user
  @override
  double get longitude;

  /// Create a copy of SfcLatLng
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SfcLatLngImplCopyWith<_$SfcLatLngImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
