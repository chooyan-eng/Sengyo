import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:toast/toast.dart';

class AppDrawer extends StatefulWidget {

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  PackageInfo _packageInfo;
  bool _isSignin = false;
  
  @override
  void initState() {
    initPackageInfo();
    initLoginState();
    super.initState();
  }

  Future<void> initPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = packageInfo;        
    });
  }

  Future<void> initLoginState() async {
    final user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _isSignin = user != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 80),
            _buildItem(Icons.person, 'プライバシーポリシー', () {}),
            _buildItem(Icons.description, '利用規約', () {}),
            _buildItem(Icons.speaker_notes, 'ライセンス', () => showLicensePage(context: context)),
            _buildItem(Icons.question_answer, 'お問い合わせ', () {}),
            InkWell(
              onTap: () async {
                if (_isSignin) {
                  await FirebaseAuth.instance.signOut();
                  await initLoginState();
                } else {
                  Toast.show('ログインします。', context);
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8),
                child: Text(_isSignin ? 'ログアウト' : 'ログイン'),
              ),
            ),
            const SizedBox(height: 40),
            Divider(),
            const SizedBox(height: 16),
            _packageInfo == null ? SizedBox.shrink() : Center(
              child: Text(
                'Ver. ${_packageInfo.version}',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.black54,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }
}