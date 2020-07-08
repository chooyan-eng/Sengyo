import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/model/article.dart';

class PostDetailBloc extends ChangeNotifier {
  Article _article;

  Article get article => _article;
  set article(Article value) {
    _article = value;
    notifyListeners();
  }  
}