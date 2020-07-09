import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  String id;
  ArticleFish fish;
  ArticleCut cut;
  ArticleCook cook;
  var isDraft;
  Timestamp createdAt;

  Article({this.id, this.fish, this.cut, this.cook, this.isDraft = true, this.createdAt});

  Map<String, dynamic> get firestoreData => {
    'about_fish': fish?.firestoreData ?? ArticleFish.empty().firestoreData,
    'about_cut': cut?.firestoreData ?? ArticleCut.empty().firestoreData,
    'about_cook': cook?.firestoreData ?? ArticleCook.empty().firestoreData,
    'is_draft': isDraft,
    'created_at': createdAt,
    'fish': fish?.fish,
  };

  factory Article.fromDocument(DocumentSnapshot document) => Article(
    id: document.documentID,
    fish: ArticleFish.fromMap(document.data['about_fish']),
    cut: ArticleCut.fromMap(document.data['about_cut']),
    cook: ArticleCook.fromMap(document.data['about_cook']),
    isDraft: document.data['is_draft'],
    createdAt: document.data['created_at'],
  );

  String get firstImagePath {
    final firstFishImage = fish.memoList.firstWhere((memo) => memo.imagePath?.isNotEmpty ?? false, orElse: () => null);
    if (firstFishImage != null) return firstFishImage.imagePath;

    final firstCutImage = cut.memoList.firstWhere((memo) => memo.imagePath?.isNotEmpty ?? false, orElse: () => null);
    if (firstCutImage != null) return firstCutImage.imagePath;

    final firstCookImage = cook.memoList.firstWhere((memo) => memo.imagePath?.isNotEmpty ?? false, orElse: () => null);
    if (firstCookImage != null) return firstCookImage.imagePath;

    return null;
  }

  String get firstMemo {
    final firstFishMemo = fish.memoList.firstWhere((memo) => memo.memo?.isNotEmpty ?? false, orElse: () => null);
    if (firstFishMemo != null) return firstFishMemo.memo;

    final firstCutMemo = cut.memoList.firstWhere((memo) => memo.memo?.isNotEmpty ?? false, orElse: () => null);
    if (firstCutMemo != null) return firstCutMemo.memo;

    final firstCookMemo = cook.memoList.firstWhere((memo) => memo.memo?.isNotEmpty ?? false, orElse: () => null);
    if (firstCookMemo != null) return firstCookMemo.memo;

    return null;
  }
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
    map['memo_list'].map<Memo>((memo) => Memo.fromMap(memo)).toList(),
  );

  factory ArticleFish.empty() => ArticleFish(null, '', []);
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
    map['memo_list'].map<Memo>((memo) => Memo.fromMap(memo)).toList(),
  );

  factory ArticleCut.empty() => ArticleCut('', []);
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
    map['memo_list'].map<Memo>((memo) => Memo.fromMap(memo)).toList(),
  );

  factory ArticleCook.empty() => ArticleCook(null, []);
}

class Memo {
  final String memo;
  final String imagePath;

  Memo(this.memo, this.imagePath);

  Map<String, dynamic> get firestoreData => {
    'memo': memo,
    'image': imagePath,
  };

  factory Memo.fromMap(Map<String, dynamic> map) => Memo(
    map['memo'],
    map['image'],
  );
}