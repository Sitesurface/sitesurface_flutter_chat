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
      required DateTime createdAt,

      /// active fcm tokens of user for sending notification
      @Default([]) final List<String> fcmTokens,

      /// time when user was last active
      required DateTime lastSeen,

      /// unique id of user
      required String id,

      /// bool for saving if user is currently active or not
      @Default(false) bool isActive,

      /// the current group  in which user is typing message
      String? typingGroup,

      /// name of user
      String? name,

      /// profile pic url of user
      String? profilePic,

      /// custom data of user which you want to save in db
      Map<String, dynamic>? data}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
