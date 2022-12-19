---
sidebar_position: 3
id: localization
title: Localization
---

You can override `ChatL10n chatL10n()` in `ChatDelegate` and return your own implementation of `ChatL10n`.

```dart
  @override
  ChatL10n chatL10n() {
    return const MyChatL10n();
  }
```

By default the app uses `EnChatL10n`. To provide your own implementation you can extend `ChatL10n` and provide your own implementation.

If you want change only some values then you can return `EnChatL10n` with new values.

```dart
  @override
  ChatL10n chatL10n() {
    return const EnChatL10n(
        onlineLabel: "On"
    );
  }
```
