import 'package:flutter/material.dart';
import 'package:sengyo/view/postlist/post_list_scene.dart';
import 'package:sengyo/view/widget/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColors.theme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PostListScene(),
    );
  }
}