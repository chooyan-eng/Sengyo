import 'package:flutter/material.dart';
import 'package:sengyo/model/article.dart';
import 'package:sengyo/view/widget/app_colors.dart';

class ReportDialog extends StatelessWidget {
  static const messages = <String>[
    'アプリの内容と関係のない投稿',
    '記載内容に危険を伴う誤りが含まれる',
    '他の投稿の複製',
    '不適切な広告が含まれている',
  ];

  final Article article;
  final ValueChanged<String> onReport;
  final VoidCallback onCancel;

  const ReportDialog({
    Key key,
    this.article,
    this.onReport,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('この投稿の問題を報告'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Divider(),
            ...messages.expand(
              (message) => [
                SimpleDialogOption(
                  child: Text(message),
                  onPressed: () => onReport(message),
                ),
                Divider(),
              ],
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: onCancel,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text('キャンセル', style: TextStyle(color: AppColors.theme)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
