// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

// update the keys in updateUser function in ChatController if the keys here are changed
@freezed
class User with _$User {
  factory User(
      {final String? createdAt,
      @Default([]) final List<String> fcmTokens,
      final String? lastSeen,
      required final String id,
      @Default(false) final bool isActive,
      final String? typingGroup,
      final Map<String, dynamic>? data}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
