import 'package:cloud_firestore/cloud_firestore.dart';

class Cook {
  final String name;
  final String image;

  Cook(this.name, this.image);

  Map<String, dynamic> get firestoreData => {
        'name': name,
        'image': image,
      };

  factory Cook.fromDocument(DocumentSnapshot document) => Cook(
        document.data()['name'],
        document.data()['image'],
      );

  static Future<Cook> fromReference(DocumentReference reference) async {
    final snapshot = await reference.get();
    return Cook.fromDocument(snapshot);
  }
}
