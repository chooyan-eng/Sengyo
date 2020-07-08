import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/bloc/article_list_bloc.dart';
import 'package:sengyo/bloc/post_list_bloc.dart';
import 'package:sengyo/view/app_drawer.dart';
import 'package:sengyo/view/postdetail/post_detail_scene.dart';
import 'package:sengyo/view/postlist/widget/pickup_list.dart';
import 'package:sengyo/view/postlist/widget/post_list_item.dart';
import 'package:sengyo/view/submit/submit_fish_scene.dart';
import 'package:sengyo/view/widget/app_colors.dart';
import 'package:sengyo/view/widget/app_text_style.dart';

class PostListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostListBloc>(
      builder: (context, postListBloc, child) => Scaffold(
        appBar: AppBar(
          title: Container(
            height: 44,
            child: TextField(
              onChanged: (value) {
                if (value.isEmpty) {
                  Provider.of<ArticleListBloc>(context, listen: false).all();
                } else {
                  final fishReference = postListBloc.findFishReference(postListBloc.filterKeyword);
                  if (fishReference != null) {
                    Provider.of<ArticleListBloc>(context, listen: false).filterByFish(fishReference);
                  }
                }
              },
              controller: postListBloc.filterController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: AppColors.theme,
                  ),
                ),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            return Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubmitFishScene()));
          },
          child: Icon(Icons.edit),
        ),
        drawer: AppDrawer(),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PickupList(
                  fishList: postListBloc.fishList,
                  onItemTap: (fish) {
                    postListBloc.filterController.text = fish.name;
                    final fishReference = postListBloc.findFishReference(fish.name);
                    if (fishReference != null) {
                      Provider.of<ArticleListBloc>(context, listen: false).filterByFish(fishReference);
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'みんなの捌いたメモ',
                          style: AppTextStyle.label,
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {},
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(4.0),
                      //     child: Row(
                      //       children: <Widget>[
                      //         Icon(Icons.sort, color: AppColors.accent),
                      //         const SizedBox(width: 4),
                      //         Text(
                      //           '新着',
                      //           style: TextStyle(
                      //             fontSize: 16,
                      //             color: AppColors.accent,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: postListBloc.articleList.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailScene(article: postListBloc.articleList[index]))),
                    child: PostListItem(article: postListBloc.articleList[index]),
                  ),
                ),
                postListBloc.articleList.isEmpty ? Center(
                  child: Text('投稿がありません'),
                ) : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}