import 'package:flutter/material.dart';
import 'package:sengyo/model/article.dart';
import 'package:sengyo/repository/article_repository.dart';

class ArticleListBloc extends ChangeNotifier {
  final repository = ArticleRepository();

  final articleList = <Article>[];

  void init() {
    repository.allStream().listen((event) {
      articleList.clear();
      articleList.addAll(event.documents.map((document) => Article.fromDocument(document)));
      notifyListeners();
    });
  }
}