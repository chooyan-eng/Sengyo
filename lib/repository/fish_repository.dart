import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sengyo/model/fish.dart';

class FishRepository {

  static const collectionName = 'fishes';

  Future<void> send(Fish fish) async {
    await Firestore.instance.collection(collectionName).document()
      .setData(fish.firestoreData);
  }

  Stream<QuerySnapshot> allStream() {
    return Firestore.instance.collection(collectionName)
      .snapshots();
  }
}