import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/bloc/submit_cut_bloc.dart';
import 'package:sengyo/view/submit/submit_cut_page.dart';

class SubmitCutScene extends StatelessWidget {

  final DocumentReference document;

  const SubmitCutScene({Key key, this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SubmitCutBloc()..document = document,
      child: SubmitCutPage(),
    );
  }
}