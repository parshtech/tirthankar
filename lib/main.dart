import 'dart:io';
import 'dart:typed_data';

import 'package:Tirthankar/core/language.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:Tirthankar/pages/home.dart';
import 'package:Tirthankar/widgets/common_methods.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();

  ByteData data =
      await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    print("In AssetAudio");
    print(notification.audioId);
    return true;
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final common_methods commonmethod = new common_methods();
  final languageSelector selectlang = new languageSelector();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    commonmethod.currentAppVersion();
    return MaterialApp(
        title: selectlang.getAlbum("Tirthankar", 1),
        home: AnimatedSplashScreen(
            duration: 3000,
            splash: 'assets/applogo.png',
            nextScreen: HomePage(),
            // nextScreen: DataTableDemo(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.white));
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
