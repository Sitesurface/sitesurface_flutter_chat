---
sidebar_position: 4
id: chat-handler
title: Chat Handler
---

Wrap your root widget with `ChatHandler`. In the below example after the user is authenticated he is pushed to `_DashboardBody`. So if the user is authenticated successfully then `_DashboardBody`is returned with `ChatHandler` wrapped on top of it else only `_DashboardBody` is returned.

`ChatHandler` contains following parameters.

- `userId` - Unique id of the current user.
- `name` - Name of the current user.
- `profilePic` - Profile pic of the current user.
- `fcmServerKey` - Cloud messaging server key for sending notifications.
- `chatDelegate` - `ChatDelegate` we created in earlier steps.

```dart
class Dashboard extends StatelessWidget {
  static const id = "/dashboard";
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    var currentUser = context.read<UserBloc>().state.currentUser;
    if (currentUser == null) return const _DashboardBody();
    return ChatHandler(
        userId: currentUser.id,
        name: currentUser.name,
        profilePic: currentUser.profilePic,
        fcmServerKey: FlavorConfig.instance.fcmKey,
        chatDelegate: ChatWidget(),
        child: const _DashboardBody(),
    );
  }
}
```

Additionally you can pass `data` to store any extra data in `User` object. You will get back this data in most of the functions of `ChatDelegate`.

:::danger Take care

By default this package gets current time using `DateTime.now()`.
But if user changes his device time then it will mess up all chats data. So someone would be able to send message even in past or future.
To fix this you can create any api and get current time from your server then you can return that time from a function. Pass that function in `getCurrentTimeUserDefined` parameter of `ChatHandler`.

:::
