import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sengyo/model/article.dart';
import 'package:sengyo/repository/article_repository.dart';
import 'package:sengyo/repository/image_file_repository.dart';

class SubmitCutBloc extends ChangeNotifier {
  final articleRepository = ArticleRepository();
  final imageRepository = ImageFileRepository();

  DocumentReference _document;
  var cautionController = TextEditingController();
  var memoController = TextEditingController();
  List<int> cutImageData;
  bool _isProcessingImage = false;
  bool _isSubmitting = false;
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

    cutImageData = await imageFile.readAsBytes();
    isProcessingImage = false;

    // ImageCrop.sampleImage(
    //   file: File(imageFile.path),
    //   preferredSize: 512,
    // ).then((sampleFile) {
    //   cutImageData = image.encodePng(image.decodeImage(sampleFile.readAsBytesSync()));

    //   isProcessingImage = false;
    //   notifyListeners();
    // });
  }

  Future<DocumentReference> submit() async {
    isSubmitting = true;
    final article = Article.fromDocument(await _document.get());

    String imagePath;
    if (cutImageData?.isNotEmpty ?? false) {
      imageRepository.uploadCutImage(cutImageData).then((snapshot) {
        imagePath = snapshot.ref.fullPath;
      });
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

    final reference =
        await articleRepository.send(article, document: _document);
    isSubmitting = false;
    return reference;
  }

  void callNotifyListeners() => notifyListeners();

  @override
  void dispose() {
    cautionController.dispose();
    memoController.dispose();
    super.dispose();
  }
}
