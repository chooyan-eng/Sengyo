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
}