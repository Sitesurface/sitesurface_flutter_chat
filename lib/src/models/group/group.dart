import 'package:freezed_annotation/freezed_annotation.dart';
import '../message/message.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed

/// When two users chat a new group is created. You can modify the custom data [data] of group using [updateGroupData] of [ChatDelegate].
class Group with _$Group {
  factory Group(
      {

      /// unique id of the group
      required final String id,

      /// last message which is sent by any of the users in group
      final Message? lastMessage,

      /// custom data which you want to save in the group
      final Map<String, dynamic>? data,

      /// list of users in the group
      required final List<String> users,

      /// timetamp when group is created or when new message is sent
      final String? timestamp,

      /// number of new messages which are not read by recepient user
      @Default(0) final int unreadMessageCount}) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
