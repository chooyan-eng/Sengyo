import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as image;
import 'package:sengyo/model/article.dart';
import 'package:sengyo/repository/article_repository.dart';
import 'package:sengyo/repository/image_file_repository.dart';

class SubmitCutBloc extends ChangeNotifier{

  final articleRepository = ArticleRepository();
  final imageRepository = ImageFileRepository();

  DocumentReference _document;
  var cautionController = TextEditingController();
  var memoController = TextEditingController();
  List<int> cutImageData;
  bool _isProcessingImage;
  bool get isSubmittable => _document != null && !_isProcessingImage;

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

    isProcessingImage = true;

    ImageCrop.sampleImage(
      file: File(imageFile.path),
      preferredSize: 1024,
    ).then((sampleFile) {
      cutImageData = image.encodePng(image.decodeImage(sampleFile.readAsBytesSync()));
      
      isProcessingImage = false;
      notifyListeners();
    });
  }

  Future<DocumentReference> submit() async {
    final article = Article.fromDocument(await _document.get());

    String imagePath;
    if (cutImageData?.isNotEmpty ?? false) {
      final onComplete = await imageRepository.uploadCutImage(cutImageData).onComplete;
      imagePath = await onComplete.ref.getPath();
    }

    article.cut = ArticleCut(
      cautionController.text,
      [
        Memo(
          memoController.text, 
          imagePath,
        ),
      ],
    );

    return await articleRepository.send(article, document: _document);
  }

  @override
  void dispose() {
    cautionController.dispose();
    memoController.dispose();
    super.dispose();
  }  
}