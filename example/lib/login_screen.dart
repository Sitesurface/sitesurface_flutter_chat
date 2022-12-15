import 'package:example/main.dart';
import 'package:flutter/material.dart';

// variables for storing dummy users data;
String currentUserId = "";
String receiverId = "";
String currentUserName = "";
String receiverName = "";
String currentUserProfilePic = "";
String receiverProfilePic = "";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sitesurface Flutter Chat")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                currentUserId = "ram";
                receiverId = "rem";
                currentUserName = "Ram";
                receiverName = "Rem";
                currentUserProfilePic =
                    "https://res.cloudinary.com/sitesurface/image/upload/v1671093949/download_dy34wu.jpg";
                receiverProfilePic =
                    "https://res.cloudinary.com/sitesurface/image/upload/v1671093999/download_1_saqzmm.jpg";
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatScreen()));
              },
              child: const Text("Login as Ram"),
            ),
            ElevatedButton(
              onPressed: () {
                currentUserId = "rem";
                receiverId = "ram";
                currentUserName = "Rem";
                receiverName = "Ram";
                currentUserProfilePic =
                    "https://res.cloudinary.com/sitesurface/image/upload/v1671093999/download_1_saqzmm.jpg";
                receiverProfilePic =
                    "https://res.cloudinary.com/sitesurface/image/upload/v1671093949/download_dy34wu.jpg";
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatScreen()));
              },
              child: const Text("Login as Rem"),
            )
          ],
        ),
      ),
    );
  }
}
