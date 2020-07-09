import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sengyo/model/article.dart';
import 'package:sengyo/model/fish.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostListBloc extends ChangeNotifier {

  final filterController = TextEditingController();
  String get filterKeyword => filterController.text;

  final _fishDocumentList = <DocumentSnapshot>[];
  List<Fish> get fishList => _fishDocumentList.map((document) => Fish.fromDocument(document)).toList();

  final _articleDocumentList = <DocumentSnapshot>[];
  List<Article> get articleList => _articleDocumentList.map((document) => Article.fromDocument(document)).toList();

  final muteList = <String>[];

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

  Future<void> mute(Article article) async {
    final pref = await SharedPreferences.getInstance();
    final muteList = pref.getStringList('mute_list') ?? [];
    muteList.add(article.id);
    await pref.setStringList('mute_list', muteList);
    
    reloadMuteList();

  }
  Future<void> unmute(Article article) async {
    final pref = await SharedPreferences.getInstance();
    final muteList = pref.getStringList('mute_list');
    if (muteList.contains(article.id)) {
      muteList.remove(article.id);
      await pref.setStringList('mute_list', muteList);
      reloadMuteList();
    }  
  }

  Future<void> reloadMuteList() async {
    final pref = await SharedPreferences.getInstance();

    muteList.clear();
    muteList.addAll(pref.getStringList('mute_list') ?? []);

    notifyListeners();
  }

  DocumentReference findFishReference(String name) {    
    final snapshot = _fishDocumentList.firstWhere((snapshot) {
      return Fish.fromDocument(snapshot).synonyms.contains(name);
    }, orElse: () => null);
    return snapshot?.reference;
  }
}