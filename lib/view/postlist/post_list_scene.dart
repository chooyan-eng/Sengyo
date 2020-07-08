import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/bloc/article_list_bloc.dart';
import 'package:sengyo/bloc/fish_list_bloc.dart';
import 'package:sengyo/bloc/post_list_bloc.dart';
import 'package:sengyo/model/article.dart';
import 'package:sengyo/model/fish.dart';
import 'package:sengyo/view/postlist/post_list_page.dart';

class PostListScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider2<ArticleListBloc, FishListBloc, PostListBloc>(
      update: (context, articleListBloc, fishListBloc, postListBloc) {
        postListBloc.updateFishList(fishListBloc.fishDocumentList.map((document) => Fish.fromDocument(document)).toList());
        postListBloc.updateArticleList(articleListBloc.articleList.map((document) => Article.fromDocument(document)).toList());
        return postListBloc;
      },
      create: (context) => PostListBloc(),
      child: PostListPage(),
    );
  }
}