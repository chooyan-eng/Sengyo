import 'package:flutter/material.dart';
import 'package:sengyo/model/fish.dart';
import 'package:sengyo/repository/fish_repository.dart';

class FishListBloc extends ChangeNotifier {
  final repository = FishRepository();

  final fishList = <Fish>[];

  void init() {
    repository.allStream().listen((event) {
      fishList.clear();
      fishList.addAll(event.documents.map((document) => Fish.fromDocument(document)));
      notifyListeners();
    });
  }
}