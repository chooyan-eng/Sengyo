import 'package:flutter/material.dart';
import 'package:sengyo/view/app_drawer.dart';
import 'package:sengyo/view/postlist/widget/pickup_list.dart';
import 'package:sengyo/view/postlist/widget/post_list_item.dart';
import 'package:sengyo/view/submit/submit_fish_scene.dart';
import 'package:sengyo/view/widget/app_colors.dart';
import 'package:sengyo/view/widget/app_text_style.dart';

class PostListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 44,
          child: TextField(
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
              suffixIcon: InkWell(
                onTap: () {},
                child: Icon(Icons.search),
              ),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            PickupList(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'みんなのお魚メモ',
                      style: AppTextStyle.label,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.sort, color: AppColors.accent),
                          const SizedBox(width: 4),
                          Text(
                            '新着',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.accent,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) => PostListItem()
            ),
          ],
        ),
      ),
    );
  }
}