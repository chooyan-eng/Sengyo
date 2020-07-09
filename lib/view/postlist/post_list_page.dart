import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/bloc/article_list_bloc.dart';
import 'package:sengyo/bloc/post_list_bloc.dart';
import 'package:sengyo/model/article.dart';
import 'package:sengyo/repository/report_repository.dart';
import 'package:sengyo/view/app_drawer.dart';
import 'package:sengyo/view/postdetail/post_detail_scene.dart';
import 'package:sengyo/view/postlist/widget/bottom_sheet_menu.dart';
import 'package:sengyo/view/postlist/widget/pickup_list.dart';
import 'package:sengyo/view/postlist/widget/post_list_item.dart';
import 'package:sengyo/view/submit/submit_fish_scene.dart';
import 'package:sengyo/view/widget/app_colors.dart';
import 'package:sengyo/view/widget/app_text_style.dart';
import 'package:toast/toast.dart';

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
                  final fishReference = postListBloc
                      .findFishReference(postListBloc.filterKeyword);
                  if (fishReference != null) {
                    Provider.of<ArticleListBloc>(context, listen: false)
                        .filterByFish(fishReference);
                  }
                }
              },
              controller: postListBloc.filterController,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 2),
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
            return Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => SubmitFishScene()));
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
                    final fishReference =
                        postListBloc.findFishReference(fish.name);
                    if (fishReference != null) {
                      Provider.of<ArticleListBloc>(context, listen: false)
                          .filterByFish(fishReference);
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
                    onTap: postListBloc.muteList.contains(postListBloc.articleList[index].id) ? null
                        : () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDetailScene(
                                  article: postListBloc.articleList[index],
                                ),
                              ),
                            ),
                    child: PostListItem(
                      article: postListBloc.articleList[index],
                      onMenuTapped: (article) =>
                          _showMenuSheet(context, article),
                      isMuted: postListBloc.muteList
                          .contains(postListBloc.articleList[index].id),
                    ),
                  ),
                ),
                postListBloc.articleList.isEmpty
                    ? Center(
                        child: Text('投稿がありません'),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showMenuSheet(BuildContext context, Article article) {
    showModalBottomSheet(
      context: context,
      builder: (c) => Container(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              BottomSheetMenu(
                icon: Icons.volume_mute,
                text:
                    context.watch<PostListBloc>().muteList.contains(article.id)
                        ? 'ミュートを解除する'
                        : 'この投稿をミュートする',
                onTap: () {
                  Navigator.pop(context);
                  final bloc =
                      Provider.of<PostListBloc>(context, listen: false);
                  if (bloc.muteList.contains(article.id)) {
                    bloc.unmute(article);
                    Toast.show('この投稿のミュートを解除しました', context,
                        duration: Toast.LENGTH_SHORT);
                  } else {
                    bloc.mute(article);
                    Toast.show('この投稿をミュートしました', context,
                        duration: Toast.LENGTH_SHORT);
                  }
                },
              ),
              BottomSheetMenu(
                  icon: Icons.report,
                  text: 'この投稿の問題を報告する',
                  onTap: () {
                    Navigator.pop(context);
                    _showReportDialog(context, article);
                  }),
              Expanded(child: SizedBox.shrink()),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      'キャンセル',
                      style: TextStyle(color: AppColors.theme, fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  _showReportDialog(BuildContext context, Article article) {
    final messages = <String>[
      'アプリの内容と関係のない投稿',
      '記載内容に危険を伴う誤りが含まれる',
      '他の投稿の複製',
      '不適切な広告が含まれている',
    ];
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: Text('この投稿の問題を報告'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Divider(),
              ...messages.expand((message) => [
                    SimpleDialogOption(
                      child: Text(message),
                      onPressed: () async {
                        await ReportRepository().send(article, message);
                        Toast.show('問題を報告しました', context,
                            duration: Toast.LENGTH_SHORT);
                        Navigator.pop(context);
                      },
                    ),
                    Divider(),
                  ]),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child:
                        Text('キャンセル', style: TextStyle(color: AppColors.theme)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
