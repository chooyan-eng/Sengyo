import 'package:flutter/material.dart';
import 'package:sengyo/view/app_drawer.dart';
import 'package:sengyo/view/submit/submit_fish_page.dart';

class PostListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubmitFishPage()));
        },
      ),
      drawer: AppDrawer(),
    );
  }
}