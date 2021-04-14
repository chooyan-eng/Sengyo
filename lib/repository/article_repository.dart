import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sengyo/model/article.dart';

class ArticleRepository {
  static const collectionName = 'articles';

  Future<DocumentReference> send(Article article,
      {DocumentReference document}) async {
    if (document == null) {
      document = FirebaseFirestore.instance.collection(collectionName).doc();
    }

    await document.set(article.firestoreData);
    return document;
  }

  Stream<QuerySnapshot> allPublishedStream() {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where('is_draft', isEqualTo: false)
        .snapshots();
  }

  Stream<QuerySnapshot> filterByFishStream(DocumentReference fish) {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .where('is_draft', isEqualTo: false)
        .where('fish', isEqualTo: fish)
        .snapshots();
  }
}
