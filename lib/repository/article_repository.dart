import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sengyo/model/article.dart';

class ArticleRepository {

  static const collectionName = 'articles';

  Future<void> send(Article article) async {
    await Firestore.instance.collection(collectionName).document()
      .setData(article.firebaseData);
  }

  Stream<QuerySnapshot> allStream() {
    return Firestore.instance.collection(collectionName)
      .orderBy('created_at', descending: true)
      .snapshots();
  }
}