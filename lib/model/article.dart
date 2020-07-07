import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final ArticleFish fish;
  final ArticleCut cut;
  final ArticleCook cook;

  Article(this.fish, this.cut, this.cook);

  Map<String, dynamic> get firebaseData => {
    'about_fish': fish.firebaseData,
    'about_cut': cut.firebaseData,
    'about_cook': cook.firebaseData,
  };
}

class ArticleFish {
  final DocumentReference fish;
  final String place;
  final List<Memo> memoList;

  ArticleFish(this.fish, this.place, this.memoList);

  Map<String, dynamic> get firebaseData => {
    'fish': fish,
    'place': place,
    'memo_list': memoList.map((memo) => memo.firebaseData).toList(),
  };
}

class ArticleCut {
  final String caution;
  final List<Memo> memoList;

  ArticleCut(this.caution, this.memoList);

  Map<String, dynamic> get firebaseData => {
    'caution': caution,
    'memo_list': memoList.map((memo) => memo.firebaseData).toList(),
  };
}

class ArticleCook {
  final DocumentReference cook;
  final List<Memo> memoList;

  ArticleCook(this.cook, this.memoList);

  Map<String, dynamic> get firebaseData => {
    'cook': cook,
    'memo_list': memoList.map((memo) => memo.firebaseData).toList(),
  };
}

class Memo {
  final String imagePath;
  final String memo;

  Memo(this.imagePath, this.memo);

  Map<String, dynamic> get firebaseData => {
    'image': imagePath,
    'memo': memo,
  };
}