import 'package:flutter/material.dart';
import 'package:sengyo/model/article.dart';
import 'package:sengyo/view/widget/app_colors.dart';
import 'package:sengyo/view/widget/bottom_sheet_menu.dart';

class PostActionSheet extends StatelessWidget {
  final Article article;
  final String muteLabel;
  final ValueChanged onMuteTap;
  final ValueChanged onReportTap;
  final VoidCallback onCancel;

  const PostActionSheet({
    Key key,
    this.article,
    this.muteLabel,
    this.onMuteTap,
    this.onReportTap,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            BottomSheetMenu(
              icon: Icons.volume_mute,
              text: muteLabel,
              onTap: () => onMuteTap(article),
            ),
            BottomSheetMenu(
              icon: Icons.report,
              text: 'この投稿の問題を報告する',
              onTap: () => onReportTap(article),
            ),
            Expanded(child: SizedBox.shrink()),
            InkWell(
              onTap: onCancel,
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
    );
  }
}
