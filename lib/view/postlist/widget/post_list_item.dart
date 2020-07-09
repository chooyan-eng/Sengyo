import 'package:flutter/material.dart';
import 'package:sengyo/model/article.dart';
import 'package:sengyo/model/cook.dart';
import 'package:sengyo/model/fish.dart';
import 'package:sengyo/view/postlist/widget/fish_image.dart';
import 'package:sengyo/view/widget/app_colors.dart';
import 'package:sengyo/view/widget/app_text_style.dart';
import 'package:sengyo/view/widget/fixed_size_image.dart';

class PostListItem extends StatelessWidget {

  final Article article;
  final ValueChanged<Article> onMenuTapped;
  final bool isMuted;

  const PostListItem({Key key, this.article, this.onMenuTapped, this.isMuted = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FutureBuilder<Fish>(
          future: Fish.fromReference(article.fish.fish),
          builder: (context, fishSnapshot) => Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                FishImage(data: fishSnapshot.data),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    fishSnapshot.data?.name ?? '', 
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => onMenuTapped(article),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(Icons.more_vert, color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
        ),
        ... isMuted ? [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.black12,
            child: Center(
              child: Text('ミュートされた投稿です'),
            ),
          ),
        ] : [
          FixedSizeImage(imagePath: article.firstImagePath),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 8,
              runSpacing: 4,
              children: [article.cook.cook].map((cookReference) => Container(
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.theme,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  child: Center(
                    child: FutureBuilder<Cook>(
                      future: Cook.fromReference(cookReference),
                      builder: (context, snapshot) => Text(
                        snapshot.hasData ? snapshot.data.name : '',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ), 
                    widthFactor: 1,
                  ),
                ),
              )).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              article.firstMemo ?? '',
              style: AppTextStyle.body,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                DateTime.fromMillisecondsSinceEpoch(article.createdAt.millisecondsSinceEpoch).toString(),
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        const Divider(),
      ],
    );
  }
}
