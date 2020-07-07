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
  bool _isProcessingImage;

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
    final onComplete = await imageRepository.uploadFishImage(fishImageData).onComplete;
    final imagePath = await onComplete.ref.getPath();

    var fish = _fishList.firstWhere((element) {
      return element.data['synonyms'].contains(nameController.text);
    }, orElse: () => null)?.reference;
    
    if (fish == null) {
      fish = await fishRepository.send(
        Fish(nameController.text, imagePath, [nameController.text]),
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

  @override
  void dispose() {
    nameController.dispose();
    placeController.dispose();
    memoController.dispose();
    super.dispose();
  }  
}