import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sitesurface_flutter_chat/sitesurface_flutter_chat.dart';

import 'firebase_options.dart';
import 'login_screen.dart';

/// You will also need to create index in your firebase project. First time you will run the project you will
/// get error in console with the link to create index you just need to follow that link and click create index.

Future<void> main() async {
  // initialise firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sitesurface Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final fcmKey =
      "AAAAUjQxMDI:APA91bFAQTX1nlAt4CYAJgX3soefu9UM7nyIKvg8PGtOyUOZsNVkgsN83yB0_n46QcQM1LEMJ8XBfZiKI3kbI2QkEzUGkaavTxNfCe2ia6eWHGTOTmXNmFgxZHdG3_ThfuAqEvQMQpTl";
  @override
  Widget build(BuildContext context) {
    /// wrap your main widget like app dashboard with [ChatHandler] and pass the required data
    return ChatHandler(
      name: currentUserName,
      profilePic: currentUserProfilePic,
      userId: currentUserId,
      fcmServerKey: fcmKey,

      /// extend ChatDelegate and implement the required methods
      chatDelegate: ChatWidget(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(currentUserName),
          actions: [
            // Get no. of unread chats
            Center(
              child: UnreadMessageCountWidget(builder: (context, count) {
                return Text("Unread Messages : $count   ");
              }),
            )
          ],
        ),

        /// [ChatListWidget] shows list of all active chats
        body: ChatListWidget(
          delegate: ChatWidget(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            /// send message to other user using [openChat]
            openChat(
                context: context,
                delegate: ChatWidget(),
                recepientId: receiverId);
          },
          child: const Icon(Icons.message),
        ),
      ),
    );
  }
}

class ChatWidget extends ChatDelegate {
  final _imagePicker = ImagePicker();
  @override
  Future<File?> getCameraImage() async {
    var xfile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (xfile != null) {
      return File(xfile.path);
    }
    return null;
  }

  @override
  Future<SfcLatLng?> getCurrentLocation(BuildContext context) async {
    return SfcLatLng(latitude: 28.6488893, longitude: 77.1390096);
  }

  @override
  Future<File?> getGalleryImage() async {
    var xfile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (xfile != null) {
      return File(xfile.path);
    }
    return null;
  }
}
