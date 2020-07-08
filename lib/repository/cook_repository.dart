import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sengyo/model/cook.dart';

class CookRepository {

  static const collectionName = 'cooks';

  Future<DocumentReference> send(Cook cook, {DocumentReference document}) async {
    if (document == null) {
      document = Firestore.instance.collection(collectionName).document();
    }
    await document.setData(cook.firestoreData);
    return document;
  }

  Stream<QuerySnapshot> allStream() {
    return Firestore.instance.collection(collectionName)
      .snapshots();
  }
}