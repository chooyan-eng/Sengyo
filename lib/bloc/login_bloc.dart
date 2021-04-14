import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info/package_info.dart';
import 'package:sengyo/app_environment.dart';

class LoginBloc extends ChangeNotifier {
  static const _storedEmailKey = 'firebase_email';
  final storage = new FlutterSecureStorage();

  User _user;
  bool get isLogin => _user != null;

  User get user => _user;
  set user(User value) {
    _user = value;
    notifyListeners();
  }

  Future<void> init() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      user = currentUser;
    }

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final deepLink = dynamicLink?.link.toString();
      final email = await storage.read(key: _storedEmailKey);
      await _authenticateWith(deepLink: deepLink, email: email);
      await storage.delete(key: _storedEmailKey);
    }, onError: (OnLinkErrorException e) async {
      print(e.message);
    });

    final data = await FirebaseDynamicLinks.instance.getInitialLink();
    final deepLink = data?.link.toString();
    if (deepLink != null) {
      final email = await storage.read(key: _storedEmailKey);
      await _authenticateWith(deepLink: deepLink, email: email);
      await storage.delete(key: _storedEmailKey);
    }
  }

  Future<void> _authenticateWith(
      {@required String deepLink, @required String email}) async {
    if (deepLink != null) {
      try {
        // メールリンクかチェック
        if (FirebaseAuth.instance.isSignInWithEmailLink(deepLink)) {
          await FirebaseAuth.instance
              .signInWithEmailLink(email: email, emailLink: deepLink);
          user = FirebaseAuth.instance.currentUser;
        }
      } catch (e) {
        debugPrint('Exception:' + e.message);
      }
    }
  }

  Future<void> sendLinkTo({@required String email}) async {
    final packageInfo = await PackageInfo.fromPlatform();
    await FirebaseAuth.instance.sendSignInLinkToEmail(
      email: email,
      actionCodeSettings: ActionCodeSettings(
        url: AppEnvironment.firebaseUrl,
        handleCodeInApp: true,
        iOSBundleId: packageInfo.packageName,
        androidPackageName: packageInfo.packageName,
        androidInstallApp: true,
        androidMinimumVersion: '12',
      ),
    );

    await storage.write(key: _storedEmailKey, value: email);
  }

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
    user = null;
  }
}
