import 'package:flutter/material.dart';
import 'package:sengyo/view/app_drawer.dart';
import 'package:sengyo/view/submit/submit_fish_page.dart';
import 'package:sengyo/view/widget/app_colors.dart';

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
          return Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubmitFishPage()));
        },
      ),
      drawer: AppDrawer(),
    );
  }
}