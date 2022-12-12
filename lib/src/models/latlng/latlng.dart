import 'package:freezed_annotation/freezed_annotation.dart';

part 'latlng.freezed.dart';
part 'latlng.g.dart';

@freezed

/// class for saving coordinated
class SfcLatLng with _$SfcLatLng {
  factory SfcLatLng(
      {

      /// latitude of user
      required final double latitude,

      /// longitude of user
      required final double longitude}) = _SfcLatLng;

  factory SfcLatLng.fromJson(Map<String, dynamic> json) =>
      _$SfcLatLngFromJson(json);
}
