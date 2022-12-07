import 'package:freezed_annotation/freezed_annotation.dart';
import '../message/message.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
class Group with _$Group {
  factory Group(
      {required final String id,
      final Message? lastMessage,
      final Map<String, dynamic>? data,
      required final List<String> users,
      final String? timestamp,
      @Default(0) final int unreadMessageCount}) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
