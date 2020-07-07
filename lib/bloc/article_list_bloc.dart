import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sengyo/repository/article_repository.dart';

class ArticleListBloc extends ChangeNotifier {
  final repository = ArticleRepository();

  final articleList = <DocumentSnapshot>[];

  void init() {
    repository.allPublishedStream().listen((event) {
      articleList.clear();
      articleList.addAll(event.documents);
      notifyListeners();
    });
  }
}