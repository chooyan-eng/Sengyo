import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/bloc/post_detail_bloc.dart';
import 'package:sengyo/model/article.dart';
import 'package:sengyo/model/cook.dart';
import 'package:sengyo/model/fish.dart';
import 'package:sengyo/repository/image_file_repository.dart';
import 'package:sengyo/repository/report_repository.dart';
import 'package:sengyo/view/postdetail/widget/detail_caution.dart';
import 'package:sengyo/view/postdetail/widget/detail_label.dart';
import 'package:sengyo/view/widget/app_colors.dart';
import 'package:sengyo/view/widget/fixed_size_image.dart';
import 'package:sengyo/view/widget/post_action_sheet.dart';
import 'package:sengyo/view/widget/report_dialog.dart';

class PostDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PostDetailBloc>(
      builder: (context, postDetailBloc, child) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            InkWell(
              onTap: () => _showMenuSheet(context, postDetailBloc.article),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FixedSizeImage(
                imagePath: postDetailBloc.article.firstImagePath,
                withMask: true,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FutureBuilder<Fish>(
                      future:
                          Fish.fromReference(postDetailBloc.article.fish.fish),
                      builder: (context, fishSnapshot) => FutureBuilder<Cook>(
                        future: Cook.fromReference(
                            postDetailBloc.article.cook.cook),
                        builder: (context, cookSnapshot) => Text(
                          fishSnapshot.hasData && cookSnapshot.hasData
                              ? '${fishSnapshot.data.name} の ${cookSnapshot.data.name}'
                              : '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    DateTime.fromMillisecondsSinceEpoch(postDetailBloc
                            .article.createdAt.millisecondsSinceEpoch)
                        .toString(),
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              ),
              SizedBox(height: 16),
              DetailLabel(
                label: '食材',
                iconFileName: 'set_meal.png',
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${postDetailBloc.article.fish.place}',
                      style: TextStyle(
                        color: AppColors.theme,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '手に入れました',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              ...postDetailBloc.article.fish.memoList.expand((memo) => [
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        memo.memo,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    memo.imagePath == null
                        ? SizedBox.shrink()
                        : SizedBox(height: 16),
                    memo.imagePath == null
                        ? SizedBox.shrink()
                        : FutureBuilder(
                            future: ImageFileRepository.toDownloadUrl(
                                memo.imagePath),
                            builder: (context, snapshot) => snapshot.hasData
                                ? Container(
                                    width: double.infinity,
                                    child: Image.network(snapshot.data),
                                  )
                                : SizedBox.shrink(),
                          ),
                  ]),
              SizedBox(height: 60),
              DetailLabel(
                label: '捌き方',
                iconFileName: 'handyman.png',
              ),
              ...postDetailBloc.article.cut.caution?.isNotEmpty ?? false
                  ? [
                      SizedBox(height: 16),
                      DetailCaution(caution: postDetailBloc.article.cut.caution)
                    ]
                  : [],
              ...postDetailBloc.article.cut.memoList.expand((memo) => [
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        memo.memo,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    memo.imagePath == null
                        ? SizedBox.shrink()
                        : SizedBox(height: 16),
                    memo.imagePath == null
                        ? SizedBox.shrink()
                        : FutureBuilder(
                            future: ImageFileRepository.toDownloadUrl(
                                memo.imagePath),
                            builder: (context, snapshot) => snapshot.hasData
                                ? Container(
                                    width: double.infinity,
                                    child: Image.network(snapshot.data),
                                  )
                                : SizedBox.shrink(),
                          ),
                  ]),
              SizedBox(height: 60),
              DetailLabel(
                label: '食べ方',
                iconFileName: 'sports_bar.png',
              ),
              ...postDetailBloc.article.cook.memoList.expand((memo) => [
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        memo.memo,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    memo.imagePath == null
                        ? SizedBox.shrink()
                        : SizedBox(height: 16),
                    memo.imagePath == null
                        ? SizedBox.shrink()
                        : FutureBuilder(
                            future: ImageFileRepository.toDownloadUrl(
                                memo.imagePath),
                            builder: (context, snapshot) => snapshot.hasData
                                ? Container(
                                    width: double.infinity,
                                    child: Image.network(snapshot.data),
                                  )
                                : SizedBox.shrink(),
                          ),
                  ]),
              SizedBox(height: 60),
            ],
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
        muteLabel: 'この投稿をミュートする',
        onMuteTap: (value) {
          Navigator.pop(context);
          Navigator.pop<bool>(context, true);
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
          // TODO: (chooyan-eng) use ScaffoldMessenger.showSnackBar
          // Toast.show('問題を報告しました', context, duration: Toast.LENGTH_SHORT);
          Navigator.pop(context);
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }
}
