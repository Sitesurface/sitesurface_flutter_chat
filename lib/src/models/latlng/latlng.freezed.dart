// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'latlng.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SfcLatLng _$SfcLatLngFromJson(Map<String, dynamic> json) {
  return _SfcLatLng.fromJson(json);
}

/// @nodoc
mixin _$SfcLatLng {
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
abstract class _$$_SfcLatLngCopyWith<$Res> implements $SfcLatLngCopyWith<$Res> {
  factory _$$_SfcLatLngCopyWith(
          _$_SfcLatLng value, $Res Function(_$_SfcLatLng) then) =
      __$$_SfcLatLngCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$$_SfcLatLngCopyWithImpl<$Res>
    extends _$SfcLatLngCopyWithImpl<$Res, _$_SfcLatLng>
    implements _$$_SfcLatLngCopyWith<$Res> {
  __$$_SfcLatLngCopyWithImpl(
      _$_SfcLatLng _value, $Res Function(_$_SfcLatLng) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$_SfcLatLng(
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
class _$_SfcLatLng implements _SfcLatLng {
  _$_SfcLatLng({required this.latitude, required this.longitude});

  factory _$_SfcLatLng.fromJson(Map<String, dynamic> json) =>
      _$$_SfcLatLngFromJson(json);

  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'SfcLatLng(latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SfcLatLng &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SfcLatLngCopyWith<_$_SfcLatLng> get copyWith =>
      __$$_SfcLatLngCopyWithImpl<_$_SfcLatLng>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SfcLatLngToJson(
      this,
    );
  }
}

abstract class _SfcLatLng implements SfcLatLng {
  factory _SfcLatLng(
      {required final double latitude,
      required final double longitude}) = _$_SfcLatLng;

  factory _SfcLatLng.fromJson(Map<String, dynamic> json) =
      _$_SfcLatLng.fromJson;

  @override
  double get latitude;
  @override
  double get longitude;
  @override
  @JsonKey(ignore: true)
  _$$_SfcLatLngCopyWith<_$_SfcLatLng> get copyWith =>
      throw _privateConstructorUsedError;
}
