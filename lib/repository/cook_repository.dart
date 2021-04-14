import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sengyo/model/cook.dart';

class CookRepository {
  static const collectionName = 'cooks';

  Future<DocumentReference> send(Cook cook,
      {DocumentReference document}) async {
    if (document == null) {
      document = FirebaseFirestore.instance.collection(collectionName).doc();
    }
    await document.set(cook.firestoreData);
    return document;
  }

  Stream<QuerySnapshot> allStream() {
    return FirebaseFirestore.instance.collection(collectionName).snapshots();
  }
}
