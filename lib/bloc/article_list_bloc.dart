import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sengyo/repository/article_repository.dart';

class ArticleListBloc extends ChangeNotifier {
  final repository = ArticleRepository();

  final articleList = <DocumentSnapshot>[];
  StreamSubscription _subscription;

  void init() {
    _listenStream(repository.allPublishedStream());
  }

  void filterByFish(DocumentReference reference) {
    _listenStream(repository.filterByFishStream(reference));
  }

  void _listenStream(Stream<QuerySnapshot> stream) {
    _subscription?.cancel();
    _subscription = stream.listen((event) {
      articleList.clear();
      articleList.addAll(event.documents);
      notifyListeners();
    });
  }
}