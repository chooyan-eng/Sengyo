import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as image;
import 'package:sengyo/model/article.dart';
import 'package:sengyo/model/fish.dart';
import 'package:sengyo/repository/article_repository.dart';
import 'package:sengyo/repository/fish_repository.dart';
import 'package:sengyo/repository/image_file_repository.dart';

class SubmitFishBloc extends ChangeNotifier{

  final articleRepository = ArticleRepository();
  final fishRepository = FishRepository();
  final imageRepository = ImageFileRepository();

  final _fishList = <DocumentSnapshot>[];

  DocumentReference _document;
  var nameController = TextEditingController();
  var placeController = TextEditingController();
  var memoController = TextEditingController();
  List<int> fishImageData;
  bool _isProcessingImage = false;
  bool get isSubmittable => !_isProcessingImage
                              && nameController.text.isNotEmpty
                              && placeController.text.isNotEmpty;

  void updateFishList(List<DocumentSnapshot> documents) {
    _fishList.clear();
    _fishList.addAll(documents);
  }

  DocumentReference get document => _document;
  set document(DocumentReference value) {
    _document = value;
    notifyListeners();
  }

  bool get isProcessingImage => _isProcessingImage;
  set isProcessingImage(bool value) {
    _isProcessingImage = value;
    notifyListeners();
  }
  
  Future<void> pickupImage() async {
    final imageFile = await ImagePicker().getImage(source: ImageSource.gallery);

    if (imageFile == null) {
      return;
    }
    fishImageData = null;
    isProcessingImage = true;

    ImageCrop.sampleImage(
      file: File(imageFile.path),
      preferredSize: 1024,
    ).then((sampleFile) {
      fishImageData = image.encodePng(image.decodeImage(sampleFile.readAsBytesSync()));
      
      isProcessingImage = false;
      notifyListeners();
    });
  }

  Future<DocumentReference> submit() async {

    String imagePath;
    if (fishImageData?.isNotEmpty ?? false) {
      final onComplete = await imageRepository.uploadFishImage(fishImageData).onComplete;
      imagePath = await onComplete.ref.getPath();
    }

    var fish = _fishList.firstWhere((element) {
      return element.data['synonyms'].contains(nameController.text);
    }, orElse: () => null)?.reference;

    final fishSnapshot = await fish?.get();
    if (fishSnapshot == null) {
      fish = await fishRepository.send(
        Fish(nameController.text, imagePath, [nameController.text]),
      );
    } else if (fishSnapshot.data['image'] == null) {
      fish = await fishRepository.send(
        Fish(nameController.text, imagePath, [nameController.text]),
        document: fish,
      );
    }

    final article = Article(
      fish: ArticleFish(
        fish,
        placeController.text,
        [
          Memo(
            memoController.text, 
            imagePath,
          ),
        ],
      ),
      isDraft: true,
    );

    return await articleRepository.send(article);
  }

  void callNotifyListeners() => notifyListeners();

  @override
  void dispose() {
    nameController.dispose();
    placeController.dispose();
    memoController.dispose();
    super.dispose();
  }  
}