import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class ImageFileRepository {

  StorageUploadTask uploadFile(Uint8List data) {
    return FirebaseStorage.instance.ref().child('footest.txt').putData(
      data,
      StorageMetadata(
        contentLanguage: 'en',
        customMetadata: <String, String>{'activity': 'test'},
      ),
    );
  }

  // TODO: path から ref を生成する
  // Future<String> getDownloadUrl(String path) async {
  //   return await ref.getDownloadURL();
  // }
}