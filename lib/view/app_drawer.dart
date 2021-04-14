import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/bloc/login_bloc.dart';
import 'package:sengyo/view/login/login_scene.dart';
import 'package:sengyo/view/widget/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  PackageInfo _packageInfo;

  @override
  void initState() {
    initPackageInfo();
    super.initState();
  }

  Future<void> initPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = packageInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              color: AppColors.theme,
              padding: const EdgeInsets.all(16.0),
              child: context.watch<LoginBloc>().isLogin
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 16),
                        Text(
                          'ログイン中',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 16),
                        InkWell(
                          onTap: () async {
                            Provider.of<LoginBloc>(context, listen: false)
                                .signout();
                            // TODO: (chooyan-eng) use ScaffoldMessenger.showSnackBar
                            // Toast.show('ログアウトしました', context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'ログアウト',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 16),
                        Text(
                          'ログインして投稿しよう',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScene()));
                          },
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'ログイン',
                                  style: TextStyle(
                                    color: AppColors.theme,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            _buildItem(Icons.person, 'プライバシーポリシー', () async {
              final url =
                  'https://chooyan-eng.github.io/SengyoStaticPages/privacy.html';
              if (await canLaunch(url)) {
                await launch(
                  url,
                  forceSafariVC: false,
                  forceWebView: false,
                );
              } else {
                throw 'Could not launch $url';
              }
            }),
            _buildItem(Icons.description, '利用規約', () async {
              final url =
                  'https://chooyan-eng.github.io/SengyoStaticPages/terms.html';
              if (await canLaunch(url)) {
                await launch(
                  url,
                  forceSafariVC: false,
                  forceWebView: false,
                );
              } else {
                throw 'Could not launch $url';
              }
            }),
            _buildItem(Icons.speaker_notes, 'ライセンス',
                () => showLicensePage(context: context)),
            Divider(),
            const SizedBox(height: 16),
            _packageInfo == null
                ? SizedBox.shrink()
                : Center(
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: Colors.black54,
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }
}
