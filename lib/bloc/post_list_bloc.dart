import 'package:flutter/material.dart';
import 'package:sengyo/model/article.dart';
import 'package:sengyo/model/fish.dart';

class PostListBloc extends ChangeNotifier {
  final fishList = <Fish>[];
  final articleList = <Article>[];

  void updateFishList(List<Fish> newList) {
    fishList.clear();
    fishList.addAll(newList);

    notifyListeners();
  }

  void updateArticleList(List<Article> newList) {
    articleList.clear();
    articleList.addAll(newList);

    notifyListeners();
  }
}