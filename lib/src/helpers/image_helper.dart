import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:sitesurface_flutter_chat/src/controllers/chat_controller.dart';

class ImageHelper {
  Future<String?> uploadImageFile(File imageFile) async {
    String? url;
    try {
      String fileName = await ChatController.instance.getCurrentTimestamp();
      Reference storageReference =
          FirebaseStorage.instance.ref().child("chat").child(fileName);

      UploadTask storageUploadTask = storageReference.putFile(imageFile);
      TaskSnapshot storageTaskSnapshot =
          await storageUploadTask.whenComplete(() => null);

      url = await storageTaskSnapshot.ref.getDownloadURL();
    } catch (e) {
      debugPrint(e.toString());
    } finally {}
    return url;
  }
}
