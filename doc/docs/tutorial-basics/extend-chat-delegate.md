---
sidebar_position: 3
id: chat-delegate
title: Chat Delegate
---

Extend your class with `ChatDelegate`. It consists of three required overrides for getting camera image, gallery image and current location. You can use plugins like [image_picker](https://pub.dev/packages/image_picker) and [geolocator](https://pub.dev/packages/geolocator) implement these functionalities. This `ChatDelegate` will be passed in few widgets in next steps.

:::tip

There are tons on functions available in `ChatDelegate` which you can override to fit your business needs.

:::

```dart

class ChatWidget extends ChatDelegate {

  final ImagePicker _picker = ImagePicker();

  @override
  Future<File?> getCameraImage() async {
    var xfile = await _picker.pickImage(source: ImageSource.camera);
    if (xfile != null) {
      return File(xfile.path);
    }
    return null;
  }

  @override
  Future<SfcLatLng?> getCurrentLocation(BuildContext context) async {
    var currentLocation = await LocationHelper.getCurrentLocation();
    if(currentLocation==null) return;
    return SfcLatLng(latitude: currentLocation.latitude, longitude: currentLocation.longitude);
  }

  @override
  Future<File?> getGalleryImage() async {
    var xfile = await _picker.pickImage(source: ImageSource.gallery);
    if (xfile != null) {
      return File(xfile.path);
    }
    return null;
  }
}

```

To check all supported overrides see [API Reference](https://pub.dev/documentation/sitesurface_flutter_chat/latest/sitesurface_flutter_chat/ChatDelegate-class.html)
