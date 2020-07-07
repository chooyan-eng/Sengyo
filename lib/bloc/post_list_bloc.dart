import 'package:flutter/material.dart';
import 'package:sengyo/model/fish.dart';

class PostListBloc extends ChangeNotifier {
  final fishList = <Fish>[];

  void updateFishList(List<Fish> newList) {
    fishList.clear();
    fishList.addAll(newList);

    notifyListeners();
  }
}