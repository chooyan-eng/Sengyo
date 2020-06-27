import 'package:flutter/material.dart';
import 'package:sengyo/view/widget/app_colors.dart';
import 'package:sengyo/view/widget/app_text_style.dart';

class PostListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/images/aodai.jpeg', // TODO: dummy
                  height: 40,
                  width: 40,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '真鯛', 
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(Icons.more_vert, color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          child: Image.asset(
            'assets/images/aodai.jpeg',
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            alignment: WrapAlignment.start,
            spacing: 8,
            runSpacing: 4,
            children: ['刺身', '煮付け', '唐揚げ'].map((e) => Container(
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.theme,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Center(
                  child: Text(
                    e, 
                    style: TextStyle(color: Colors.white, fontSize: 12),
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
            'ここにコメント　ここにコメント　ここにコメント　ここにコメント　ここにコメント　ここにコメント　ここにコメント　ここにコメント　',
            style: AppTextStyle.body,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              '2020.08.10',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Divider(),
      ],
    );
  }
}
