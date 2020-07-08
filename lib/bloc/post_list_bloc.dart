import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sengyo/model/article.dart';
import 'package:sengyo/model/fish.dart';

class PostListBloc extends ChangeNotifier {

  final filterController = TextEditingController();
  String get filterKeyword => filterController.text;

  final _fishDocumentList = <DocumentSnapshot>[];
  List<Fish> get fishList => _fishDocumentList.map((document) => Fish.fromDocument(document)).toList();

  final _articleDocumentList = <DocumentSnapshot>[];
  List<Article> get articleList => _articleDocumentList.map((document) => Article.fromDocument(document)).toList();

  void updateFishList(List<DocumentSnapshot> newList) {
    _fishDocumentList.clear();
    _fishDocumentList.addAll(newList);

    notifyListeners();
  }

  void updateArticleList(List<DocumentSnapshot> newList) {
    _articleDocumentList.clear();
    _articleDocumentList.addAll(newList);

    notifyListeners();
  }

  DocumentReference findFishReference(String name) {
    final snapshot = _fishDocumentList.firstWhere((snapshot) {
      return Fish.fromDocument(snapshot).synonyms.contains(name);
    }, orElse: () => null);
    return snapshot?.reference;
  }
}