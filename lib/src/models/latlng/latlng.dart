import 'package:freezed_annotation/freezed_annotation.dart';

part 'latlng.freezed.dart';
part 'latlng.g.dart';

@freezed
class SfcLatLng with _$SfcLatLng {
  factory SfcLatLng(
      {required final double latitude,
      required final double longitude}) = _SfcLatLng;

  factory SfcLatLng.fromJson(Map<String, dynamic> json) =>
      _$SfcLatLngFromJson(json);
}
