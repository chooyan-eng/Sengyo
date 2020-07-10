import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/bloc/fish_list_bloc.dart';
import 'package:sengyo/bloc/login_bloc.dart';
import 'package:sengyo/bloc/submit_fish_bloc.dart';
import 'package:sengyo/view/submit/submit_fish_page.dart';

class SubmitFishScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider2<FishListBloc, LoginBloc, SubmitFishBloc>(
      create: (context) => SubmitFishBloc(),
      update: (context, fishListBloc, loginBloc, submitFishBloc) {
        submitFishBloc.updateFishList(fishListBloc.fishDocumentList);
        submitFishBloc.authorId = loginBloc.user.uid;
        return submitFishBloc;
      },
      child: SubmitFishPage()
    );
  }
}