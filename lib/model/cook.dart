class Cook {
  final String name;
  final String image;

  Cook(this.name, this.image);

  Map<String, dynamic> get firestoreData => {
    'name': name,
    'image': image,
  };
}