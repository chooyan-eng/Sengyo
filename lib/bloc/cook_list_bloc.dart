import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sengyo/repository/cook_repository.dart';

class CookListBloc extends ChangeNotifier {
  final repository = CookRepository();

  final fishDocumentList = <DocumentSnapshot>[];

  void init() {
    repository.allStream().listen((event) {
      fishDocumentList.clear();
      fishDocumentList.addAll(event.docs);
      notifyListeners();
    });
  }
}
