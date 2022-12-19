import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import '../controllers/chat_controller.dart';

class ImageHelper {
  Future<String?> uploadImageFile(File imageFile) async {
    String? url;
    try {
      final fileName = await ChatController.instance.getCurrentTimestamp();
      final storageReference =
          FirebaseStorage.instance.ref().child('chat').child(fileName);

      final storageUploadTask = storageReference.putFile(imageFile);
      final storageTaskSnapshot =
          await storageUploadTask.whenComplete(() => null);

      url = await storageTaskSnapshot.ref.getDownloadURL();
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
    return url;
  }
}
