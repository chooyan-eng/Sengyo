import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sengyo/model/article.dart';

class ArticleRepository {

  static const collectionName = 'articles';

  Future<DocumentReference> send(Article article, {DocumentReference document}) async {
    if (document == null) {
      document = Firestore.instance.collection(collectionName).document();
    }

    await document.setData(article.firestoreData);
    return document;
  }

  Stream<QuerySnapshot> allStream() {
    return Firestore.instance.collection(collectionName)
      .orderBy('created_at', descending: true)
      .snapshots();
  }
}