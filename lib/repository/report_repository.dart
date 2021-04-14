import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sengyo/model/article.dart';

class ReportRepository {
  static const collectionName = 'reports';

  Future<DocumentReference> send(Article article, String message) async {
    final document =
        FirebaseFirestore.instance.collection(collectionName).doc();
    await document.set({
      'article': article.id,
      'message': message,
      'created_at': Timestamp.now(),
    });
    return document;
  }
}
