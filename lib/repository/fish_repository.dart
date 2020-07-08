import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sengyo/model/fish.dart';

class FishRepository {

  static const collectionName = 'fishes';

  Future<DocumentReference> send(Fish fish, {DocumentReference document}) async {
    if (document == null) {
      document = Firestore.instance.collection(collectionName).document();
    }
    await document.setData(fish.firestoreData);
    return document;
  }

  Stream<QuerySnapshot> allStream() {
    return Firestore.instance.collection(collectionName)
      .snapshots();
  }

  Stream<QuerySnapshot> withImageStream() {
    return Firestore.instance.collection(collectionName)
      .where('image', isGreaterThanOrEqualTo: '') // where image not null
      .snapshots();
  }
}