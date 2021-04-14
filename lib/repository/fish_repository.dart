import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sengyo/model/fish.dart';

class FishRepository {
  static const collectionName = 'fishes';

  Future<DocumentReference> send(Fish fish,
      {DocumentReference document}) async {
    if (document == null) {
      document = FirebaseFirestore.instance.collection(collectionName).doc();
    }
    await document.set(fish.firestoreData);
    return document;
  }

  Stream<QuerySnapshot> allStream() {
    return FirebaseFirestore.instance.collection(collectionName).snapshots();
  }

  Stream<QuerySnapshot> withImageStream() {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where('image', isGreaterThanOrEqualTo: '') // where image not null
        .snapshots();
  }
}
