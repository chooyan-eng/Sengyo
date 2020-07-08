import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/bloc/post_detail_bloc.dart';
import 'package:sengyo/model/article.dart';
import 'package:sengyo/view/postdetail/post_detail_page.dart';

class PostDetailScene extends StatelessWidget {

  final Article article;

  const PostDetailScene({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostDetailBloc>(
      create: (context) => PostDetailBloc()..article = article,
      child: PostDetailPage(),
    );
  }
}