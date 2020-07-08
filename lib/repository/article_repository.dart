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

  Stream<QuerySnapshot> allPublishedStream() {
    return Firestore.instance.collection(collectionName)
      .where('is_draft', isEqualTo: false)
      .snapshots();
  }
}