---
sidebar_position: 2
id: themes
title: Themes
---

You can override `ChatTheme chatTheme()` in `ChatDelegate` and return your own implementation of `ChatTheme`.

```dart
  @override
  ChatTheme chatTheme() {
    return const MyChatTheme();
  }
```

By default the app uses `DefaultChatTheme`. To provide your own implementation you can extend `ChatTheme` and provide your own implementation.

If you want change only some values then you can return `DefaultChatTheme` with new values.

```dart
  @override
  ChatTheme chatTheme() {
    return const DefaultChatTheme(
        appBarBackgroundColor: Colors.red
    );
  }
```
