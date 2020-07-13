import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as image;
import 'package:sengyo/model/article.dart';
import 'package:sengyo/model/cook.dart';
import 'package:sengyo/repository/article_repository.dart';
import 'package:sengyo/repository/cook_repository.dart';
import 'package:sengyo/repository/image_file_repository.dart';

class SubmitCookBloc extends ChangeNotifier{

  final articleRepository = ArticleRepository();
  final cookRepository = CookRepository();
  final imageRepository = ImageFileRepository();

  final _cookList = <DocumentSnapshot>[];

  DocumentReference _document;
  var nameController = TextEditingController();
  var memoController = TextEditingController();
  List<int> cookImageData;
  bool _isProcessingImage = false;
  bool _isSubmitting = false;
  bool get isSubmittable => _document != null 
                              && !_isProcessingImage
                              && nameController.text.isNotEmpty;

  void updateCookList(List<DocumentSnapshot> documents) {
    _cookList.clear();
    _cookList.addAll(documents);
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
  
  bool get isSubmitting => _isSubmitting;
  set isSubmitting(bool value) {
    _isSubmitting = value;
    notifyListeners();
  }

  Future<void> pickupImage() async {
    final imageFile = await ImagePicker().getImage(source: ImageSource.gallery);

    if (imageFile == null) {
      return;
    }

    isProcessingImage = true;

    ImageCrop.sampleImage(
      file: File(imageFile.path),
      preferredSize: 512,
    ).then((sampleFile) {
      cookImageData = image.encodePng(image.decodeImage(sampleFile.readAsBytesSync()));
      
      isProcessingImage = false;
      notifyListeners();
    });
  }

  Future<DocumentReference> submit() async {
    isSubmitting = true;

    final article = Article.fromDocument(await _document.get());

    String imagePath;
    if (cookImageData?.isNotEmpty ?? false) {
      final onComplete = await imageRepository.uploadCookImage(cookImageData).onComplete;
      imagePath = await onComplete.ref.getPath();
    }

    var cook = _cookList.firstWhere((element) {
      return element.data['name'] == nameController.text;
    }, orElse: () => null)?.reference;

    final cookSnapshot = await cook?.get();
    if (cookSnapshot == null) {
      cook = await cookRepository.send(
        Cook(nameController.text, imagePath),
      );
    } else if (cookSnapshot.data['image'] == null) {
      cook = await cookRepository.send(
        Cook(nameController.text, imagePath),
        document: cook,
      );
    }

    article.cook = ArticleCook(
      cook,
      [
        Memo(
          memoController.text, 
          imagePath,
        ),
      ],
    );
    article.isDraft = false;
    article.createdAt = Timestamp.now();

    final reference = await articleRepository.send(article, document: document);
    isSubmitting = false;
    return reference;
  }

  void callNotifyListeners() => notifyListeners();

  @override
  void dispose() {
    nameController.dispose();
    memoController.dispose();
    super.dispose();
  }  
}