import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:crypto/crypto.dart';

class ImageFileRepository {
  UploadTask uploadFishImage(Uint8List data) {
    return uploadFile(data, 'fish');
  }

  UploadTask uploadCutImage(Uint8List data) {
    return uploadFile(data, 'cut');
  }

  UploadTask uploadCookImage(Uint8List data) {
    return uploadFile(data, 'cook');
  }

  UploadTask uploadFile(Uint8List data, String directory) {
    final digest = sha256.convert(data);
    return FirebaseStorage.instance
        .ref()
        .child('images')
        .child(directory)
        .child('$digest.png')
        .putData(
          data,
          SettableMetadata(contentLanguage: 'en', contentType: 'image/png'),
        );
  }

  static Future<String> toDownloadUrl(String path) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    return await ref.getDownloadURL();
  }
}
