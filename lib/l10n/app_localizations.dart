import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'labelPosts': {
      'en': 'Posts',
      'ja': 'みんなの投稿',
    },
    'labelPickups': {
      'en': 'Features',
      'ja': '最近投稿があった食材',
    },
    'messageLogin': {
      'en': 'Sign in and Post Your Stories.',
      'ja': 'ログインして投稿しよう',
    },
    'mail': {
      'en': 'your E-mail address',
      'ja': 'メールアドレス',
    },
    'login': {
      'en': 'Sign in',
      'ja': 'ログイン',
    },
    'loginRequired': {
      'en': 'Sing in required',
      'ja': 'ログインしてください',
    },
    'loginRequiredMessage1': {
      'en': 'Singing in is required to post your story.',
      'ja': '捌いたメモの投稿にはログインが必要です。',
    },
    'howtoLogin': {
      'en': 'Steps to Sign in',
      'ja': 'ログインの方法',
    },
    'loginDetail1': {
      'en':
          'E-mail containing a link to sign in would be sent to your E-mail address.',
      'ja': '指定したメールアドレスにログイン用のメールが送信されます。',
    },
    'loginDetail2': {
      'en':
          'Tap the link and "Sengyo" app would automatically open, and signing in would be completed.',
      'ja': 'メール内のログイン用URLをタップすればアプリが開いてログインが完了します。',
    },
    'sendMail': {
      'en': 'Send E-mail',
      'ja': 'メールを送信',
    },
    'loginMailSent': {
      'en': 'E-mail with the sign in link is sent.',
      'ja': 'ログイン用メールを送信しました。',
    },
    'loginNote1': {
      'en': '* This app doesn\'t use any Password.',
      'ja': '※ パスワードは必要ありません。',
    },
    'loginNote2': {
      'en':
          '* Make sure to check junk folders if no E-mail would sent to your E-mail address.',
      'ja': '※ メールが届かない場合は迷惑メールフォルダもご確認ください。',
    },
    'privacyPolicy': {
      'en': 'Privacy Policy',
      'ja': '最近投稿があった食材',
    },
    'terms': {
      'en': 'Features',
      'ja': '最近投稿があった食材',
    },
    'license': {
      'en': 'Features',
      'ja': '最近投稿があった食材',
    },
    'labelFish': {
      'en': 'Fish',
      'ja': '食材',
    },
    'labelCut': {
      'en': 'How to cut',
      'ja': '捌き方',
    },
    'labelCaution': {
      'en': 'Notice',
      'ja': '注意',
    },
    'labelCook': {
      'en': 'Menu',
      'ja': '食べ方',
    },
    'cancel': {
      'en': 'Cancel',
      'ja': 'キャンセル',
    },
  };

  String get labelPosts => _localizedValues['labelPosts'][locale.languageCode];
  String get labelPickups =>
      _localizedValues['labelPickups'][locale.languageCode];
}
