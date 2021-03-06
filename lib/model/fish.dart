import 'package:cloud_firestore/cloud_firestore.dart';

class Fish {
  final String name;
  final String imagePath;
  final List<String> synonyms;

  Fish(this.name, this.imagePath, this.synonyms);

  Map<String, dynamic> get firestoreData => {
    'name': name,
    'image': imagePath,
    'synonyms': synonyms,
  };

  factory Fish.fromDocument(DocumentSnapshot document) => Fish(
    document.data['name'],
    document.data['image'],
    document.data['synonyms'].map<String>((synonym) => synonym as String).toList(),
  );

  static Future<Fish> fromReference(DocumentReference reference) async {
    final snapshot = await reference.get();
    return Fish.fromDocument(snapshot);
  }
}