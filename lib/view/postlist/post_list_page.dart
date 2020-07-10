import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/bloc/article_list_bloc.dart';
import 'package:sengyo/bloc/login_bloc.dart';
import 'package:sengyo/bloc/post_list_bloc.dart';
import 'package:sengyo/model/article.dart';
import 'package:sengyo/repository/report_repository.dart';
import 'package:sengyo/view/app_drawer.dart';
import 'package:sengyo/view/login/login_scene.dart';
import 'package:sengyo/view/postdetail/post_detail_scene.dart';
import 'package:sengyo/view/postlist/widget/pickup_list.dart';
import 'package:sengyo/view/postlist/widget/post_list_item.dart';
import 'package:sengyo/view/submit/submit_fish_scene.dart';
import 'package:sengyo/view/widget/app_colors.dart';
import 'package:sengyo/view/widget/app_text_style.dart';
import 'package:sengyo/view/widget/post_action_sheet.dart';
import 'package:sengyo/view/widget/report_dialog.dart';
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
            if (Provider.of<LoginBloc>(context, listen: false).isLogin) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubmitFishScene()));
            } else {
              _showLoginDialog(context);
            }
          },
          child: Icon(Icons.edit),
          backgroundColor: context.watch<LoginBloc>().isLogin ? AppColors.theme : Colors.grey,
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
                    onTap: postListBloc.muteList
                            .contains(postListBloc.articleList[index].id)
                        ? null
                        : () async {
                            final needMute = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDetailScene(
                                  article: postListBloc.articleList[index],
                                ),
                              ),
                            );
                            if (needMute ?? false) {
                              postListBloc.mute(postListBloc.articleList[index]);
                              Toast.show('この投稿をミュートしました', context, duration: Toast.LENGTH_SHORT);
                            }
                          },
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
      builder: (c) => PostActionSheet(
        article: article,
        muteLabel: context.watch<PostListBloc>().muteList.contains(article.id)
            ? 'ミュートを解除する'
            : 'この投稿をミュートする',
        onMuteTap: (value) {
          Navigator.pop(context);
          final bloc = Provider.of<PostListBloc>(context, listen: false);
          if (bloc.muteList.contains(article.id)) {
            bloc.unmute(article);
            Toast.show('この投稿のミュートを解除しました', context,
                duration: Toast.LENGTH_SHORT);
          } else {
            bloc.mute(article);
            Toast.show('この投稿をミュートしました', context, duration: Toast.LENGTH_SHORT);
          }
        },
        onReportTap: (value) {
          Navigator.pop(context);
          _showReportDialog(context, article);
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  _showReportDialog(BuildContext context, Article article) {
    showDialog(
      context: context,
      builder: (c) => ReportDialog(
        article: article,
        onReport: (message) async {
          await ReportRepository().send(article, message);
          Toast.show('問題を報告しました', context, duration: Toast.LENGTH_SHORT);
          Navigator.pop(context);
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          color: AppColors.theme,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'ログインしてください',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('捌いたメモの投稿にはアカウントへのログインが必要です。'),
            const SizedBox(height: 16),
            Text('ログインしますか？'),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Text('キャンセル'),
                ),
                const SizedBox(width: 16),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScene()));
                  },
                  child: Text(
                    'ログイン',
                    style: TextStyle(
                      color: AppColors.theme,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
