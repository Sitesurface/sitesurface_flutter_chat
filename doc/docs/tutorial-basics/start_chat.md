---
sidebar_position: 4
id: start-chat
title: Start Chat
---

To start chat with other user you can call `openChat` function. It contains two required parameters.

- `delegate` - the `ChatDelegate` we created in earlier steps.
- `recepientId` - the unique id of the user with whom you want to chat.

```dart
openChat(
    context: context,
    delegate: ChatWidget(),
    recepientId: recepientUserId,
);
```

## Optional

By default two users will always have the same chat like Whatsapp. But if you want to separate your chat based on the orders regarding which the chat is created you can pass the optional parameter `orderId`. So if you pass `orderId` same two users can have multiple chat groups differentiated by `orderId`.

There is one more optional parameter `groupData`. You can pass any extra data which you would like to save in the group. You will get back this data in `Group` object in most of the callbacks.

```dart
openChat(
    context: context,
    delegate: ChatWidget(),
    recepientId: recepientUser,
    orderId: post.id,
    groupData: ChatGroup(
            type: ChatGroupType.POST,
            post: post,
            postUserId: seller.id)
        .toJson(),
);
```

In my app users can create some posts and other users can view that post and chat with the user who created it. Same user can create multiple posts. So i'm passing `orderId` so that there chats for each post remains separated. Additionally i'm passing `groupData` as i want different UI's based on post data. I'll get back this data in `ChatListWidget` builder function in `group.data` so i'll return different widgets for different types of post.

:::danger Take care

`openChat` should only be called after the `ChatHandler` has been mounted in widget tree as the `ChatHandler` performs various operations in background to initialise the current user.

:::
