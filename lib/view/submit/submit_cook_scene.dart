import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sengyo/view/submit/submit_cook_page.dart';

class SubmitCookScene extends StatelessWidget {

  final DocumentReference document;

  const SubmitCookScene({Key key, this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SubmitCookPage();
  }
}