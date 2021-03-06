import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/bloc/fish_list_bloc.dart';
import 'package:sengyo/bloc/login_bloc.dart';
import 'package:sengyo/view/postlist/post_list_scene.dart';
import 'package:sengyo/view/splash_page.dart';
import 'package:sengyo/view/widget/app_colors.dart';

import 'bloc/article_list_bloc.dart';
import 'bloc/cook_list_bloc.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        ChangeNotifierProvider<FishListBloc>(
          create: (context) => FishListBloc()..init(),
        ),
        ChangeNotifierProvider<CookListBloc>(
          create: (context) => CookListBloc()..init(),
        ),
        ChangeNotifierProvider<ArticleListBloc>(
          create: (context) => ArticleListBloc()..all(),
        ),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColors.theme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
    );
  }
}