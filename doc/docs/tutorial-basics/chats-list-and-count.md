---
sidebar_position: 5
id: chats-list-and-count
title: Chats List And Count
---

You can use `ChatListWidget` to show the list of chats.In delegate pass the `ChatDelegate` you created in earlier steps.

```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      body: ChatListWidget(
        delegate: ChatWidget(),
      ),
    );
  }
```

If you want to build your own UI for chat tiles then you can pass `builder` parameter in `ChatListWidget`.
Here `user` contains the data of recepient user. `group` contains the data about the chat group. `isTyping` indicates whether the recepient user is typing or not.

```dart
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      body: ChatListWidget(
        delegate: ChatWidget(),
        builder: (context, user, isTyping, group, index){
            return MyChatTile();
        }
      ),
    );
  }
```

## Unread messages count

`builder` of `UnreadMessageCountWidget` widget returns the count of number of unread messages. You can wrap it in your bottom navigation bar to show the count like whatsapp.

```dart
BottomNavigationBarItem(
              icon: UnreadMessageCountWidget(
                builder: (context, count) {
                  if (count == 0) return const Icon(MdiIcons.message);
                  return Badge(
                    badgeColor: colorScheme.primary,
                    showBadge: count != 0,
                    badgeContent: Text(
                      count.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                    child: const Icon(MdiIcons.message),
                  );
                },
              ),
              label: 'Chats'
)
```

:::tip My tip

You can use [badges](https://pub.dev/packages/badges) package to show count.

:::
