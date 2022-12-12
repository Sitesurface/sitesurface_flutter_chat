// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

// update the keys in updateUser function in ChatController if the keys here are changed
@freezed

/// Object of user. You can update the user using [updateUserData] funtion of [ChatDelegate].
class User with _$User {
  factory User(
      {

      /// Time when user is created
      final String? createdAt,

      /// active fcm tokens of user for sending notification
      @Default([]) final List<String> fcmTokens,

      /// time when user was last active
      final String? lastSeen,

      /// unique id of user
      required final String id,

      /// bool for saving if user is currently active or not
      @Default(false) final bool isActive,

      /// the current group  in which user is typing message
      final String? typingGroup,

      /// name of user
      final String? name,

      /// profile pic url of user
      final String? profilePic,

      /// custom data of user which you want to save in db
      final Map<String, dynamic>? data}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
