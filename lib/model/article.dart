import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final ArticleFish fish;
  final ArticleCut cut;
  final ArticleCook cook;

  Article(this.fish, this.cut, this.cook);

  Map<String, dynamic> get firestoreData => {
    'about_fish': fish.firestoreData,
    'about_cut': cut.firestoreData,
    'about_cook': cook.firestoreData,
  };

  factory Article.fromDocument(DocumentSnapshot document) => Article(
    ArticleFish.fromMap(document.data['about_fish']),
    ArticleCut.fromMap(document.data['about_cut']),
    ArticleCook.fromMap(document.data['about_cook']),
  );
}

class ArticleFish {
  final DocumentReference fish;
  final String place;
  final List<Memo> memoList;

  ArticleFish(this.fish, this.place, this.memoList);

  Map<String, dynamic> get firestoreData => {
    'fish': fish,
    'place': place,
    'memo_list': memoList.map((memo) => memo.firestoreData).toList(),
  };

  factory ArticleFish.fromMap(Map<String, dynamic> map) => ArticleFish(
    map['fish'],
    map['place'],
    map['memo_list'].map((memo) => Memo.fromMap(memo)).toList(),
  );
}

class ArticleCut {
  final String caution;
  final List<Memo> memoList;

  ArticleCut(this.caution, this.memoList);

  Map<String, dynamic> get firestoreData => {
    'caution': caution,
    'memo_list': memoList.map((memo) => memo.firestoreData).toList(),
  };

  factory ArticleCut.fromMap(Map<String, dynamic> map) => ArticleCut(
    map['caution'],
    map['memo_list'].map((memo) => Memo.fromMap(memo)).toList(),
  );
}

class ArticleCook {
  final DocumentReference cook;
  final List<Memo> memoList;

  ArticleCook(this.cook, this.memoList);

  Map<String, dynamic> get firestoreData => {
    'cook': cook,
    'memo_list': memoList.map((memo) => memo.firestoreData).toList(),
  };

  factory ArticleCook.fromMap(Map<String, dynamic> map) => ArticleCook(
    map['cook'],
    map['memo_list'].map((memo) => Memo.fromMap(memo)).toList(),
  );
}

class Memo {
  final String imagePath;
  final String memo;

  Memo(this.imagePath, this.memo);

  Map<String, dynamic> get firestoreData => {
    'image': imagePath,
    'memo': memo,
  };

  factory Memo.fromMap(Map<String, dynamic> map) => Memo(
    map['image'],
    map['memo'],
  );
}