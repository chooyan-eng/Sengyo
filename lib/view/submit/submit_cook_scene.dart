import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/bloc/cook_list_bloc.dart';
import 'package:sengyo/bloc/submit_cook_bloc.dart';
import 'package:sengyo/view/submit/submit_cook_page.dart';

class SubmitCookScene extends StatelessWidget {

  final DocumentReference document;

  const SubmitCookScene({Key key, this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CookListBloc, SubmitCookBloc>(
      create: (context) => SubmitCookBloc()..document = document,
      update: (context, cookListBloc, submitCookBloc) {
        return submitCookBloc..updateCookList(cookListBloc.fishDocumentList);
      },
      child: SubmitCookPage(),
    );
  }
}