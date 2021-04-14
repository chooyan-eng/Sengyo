import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sengyo/bloc/login_bloc.dart';
import 'package:sengyo/view/widget/app_colors.dart';
import 'package:sengyo/view/widget/app_text_style.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = TextEditingController();

  bool _isSending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  MediaQuery.of(context).size.width,
                ),
                bottomLeft: Radius.circular(
                  MediaQuery.of(context).size.width,
                ),
              ),
              child: Image.asset(
                'assets/images/splash.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.topLeft,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(220),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'ログインの方法',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.theme,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '指定したメールアドレスにログイン用のメールが送信されます。',
                    style: AppTextStyle.body,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'メール内のログイン用URLをタップすればアプリが開いてログインが完了します。',
                    style: AppTextStyle.body,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: controller,
                    decoration: const InputDecoration(
                      labelText: 'メールアドレス',
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 60),
                  RaisedButton(
                    onPressed: _isSending
                        ? null
                        : () async {
                            setState(() {
                              _isSending = true;
                            });

                            await Provider.of<LoginBloc>(context, listen: false)
                                .sendLinkTo(email: controller.text);

                            setState(() {
                              _isSending = false;
                            });

                            // TODO: (chooyan-eng) use ScaffoldMessenger.showSnackBar
                            // Toast.show('ログイン用メールを送信しました。', context);
                            Navigator.pop(context);
                          },
                    padding: const EdgeInsets.all(0.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 52,
                      decoration: BoxDecoration(
                        color: _isSending ? Colors.black12 : AppColors.theme,
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: _isSending
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text(
                                'メールを送信',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    '※ パスワードは必要ありません。',
                    style: TextStyle(fontSize: 12.0, color: AppColors.theme),
                  ),
                  Text(
                    '※ メーラーにより迷惑メールフォルダに振り分けられる場合があります。迷惑メールフォルダもご確認ください。',
                    style: TextStyle(fontSize: 12.0, color: AppColors.theme),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
