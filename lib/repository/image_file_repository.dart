import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:crypto/crypto.dart';

class ImageFileRepository {

  StorageUploadTask uploadFishImage(Uint8List data) {
    return uploadFile(data, 'fish');
  }

  StorageUploadTask uploadCutImage(Uint8List data) {
    return uploadFile(data, 'cut');
  }

  StorageUploadTask uploadCookImage(Uint8List data) {
    return uploadFile(data, 'cook');
  }

  StorageUploadTask uploadFile(Uint8List data, String directory) {
    final digest = sha256.convert(data);
    return FirebaseStorage.instance.ref().child('images').child(directory).child('$digest.png').putData(
      data,
      StorageMetadata(
        contentLanguage: 'en',
        contentType: 'image/png'
      ),
    );
  }

  // TODO: path から ref を生成する
  // Future<String> getDownloadUrl(String path) async {
  //   return await ref.getDownloadURL();
  // }
}