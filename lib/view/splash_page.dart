import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:sengyo/view/postlist/post_list_scene.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  static final messageList = <String>[
    'みんなの「捌いた！」をシェアしよう',
    '今日はどんな魚を捌きましたか？',
    '旬の食材を調べてみよう',
    'あの魚、家でも捌けるのかな？',
    'みんなはどこで包丁買ってるんだろう',
    '背骨、腹骨、血合骨',
    'いつか市場で買ってみたい',
    'ガイドラインを入れましょう',
    '「銀色のやつ！」',
    '「捌いていく！」',
  ];

  @override
  void initState() {
    Future.delayed(
      Duration(milliseconds: 1000), 
      () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PostListScene()));
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              'assets/images/splash.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.topLeft,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(180),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    messageList[Random().nextInt(messageList.length)],
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 120),
                CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(
                  'データを読み込んでいます',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}