import 'package:flutter/material.dart';

/// Base chat l10n containing all required properties to provide localized copy.
/// Extend this class if you want to create a custom l10n.
@immutable
abstract class ChatL10n {
  /// Creates a new chat l10n based on provided copy.
  const ChatL10n({
    required this.onlineLabel,
    required this.lastSeenLabel,
    required this.typingLabel,
    required this.yesterdayLabel,
    required this.todayLabel,
    required this.cameraAttachmentLabel,
    required this.galleryAttachmentLabel,
    required this.locationAttachmentLabel,
    required this.messageInputHint,
    required this.sharedImageLabel,
    required this.sharedLocationLabel,
    required this.noChatMessagesLabel,
  });

  /// Online Text label on chat screen
  final String onlineLabel;

  /// Last Seen text label on chat screen
  final String lastSeenLabel;

  /// Typing text label on chat screen
  final String typingLabel;

  /// Yesterday label
  final String yesterdayLabel;

  /// Today label
  final String todayLabel;

  /// Camera attachment text label
  final String cameraAttachmentLabel;

  /// Gallery attachment text label
  final String galleryAttachmentLabel;

  /// Location attachment text label
  final String locationAttachmentLabel;

  /// Message input text hint
  final String messageInputHint;

  /// Shared Image label
  final String sharedImageLabel;

  /// Shared Location label
  final String sharedLocationLabel;

  /// No chat messages label
  final String noChatMessagesLabel;
}

class EnChatL10n extends ChatL10n {
  const EnChatL10n(
      {super.onlineLabel = 'Online',
      super.lastSeenLabel = 'last seen',
      super.typingLabel = 'Typing....',
      super.yesterdayLabel = 'YESTERDAY',
      super.todayLabel = 'TODAY',
      super.cameraAttachmentLabel = 'Camera',
      super.galleryAttachmentLabel = 'Gallery',
      super.locationAttachmentLabel = 'Location',
      super.messageInputHint = 'Message',
      super.sharedImageLabel = 'Shared image',
      super.sharedLocationLabel = 'Shared location',
      super.noChatMessagesLabel = 'No chats found'});
}
