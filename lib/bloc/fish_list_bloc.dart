import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sengyo/repository/fish_repository.dart';

class FishListBloc extends ChangeNotifier {
  final repository = FishRepository();

  final fishDocumentList = <DocumentSnapshot>[];

  void init() {
    repository.allStream().listen((event) {
      fishDocumentList.clear();
      fishDocumentList.addAll(event.documents);
      notifyListeners();
    });
  }
}