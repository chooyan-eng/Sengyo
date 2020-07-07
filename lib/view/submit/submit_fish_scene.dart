import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/bloc/fish_list_bloc.dart';
import 'package:sengyo/bloc/submit_fish_bloc.dart';
import 'package:sengyo/view/submit/submit_fish_page.dart';

class SubmitFishScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<FishListBloc, SubmitFishBloc>(
      create: (context) => SubmitFishBloc(),
      update: (context, fishListBloc, submitFishBloc) {
        return submitFishBloc..updateFishList(fishListBloc.fishDocumentList);
      },
      child: SubmitFishPage()
    );
  }
}