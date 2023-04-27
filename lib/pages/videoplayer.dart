// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';

import 'package:Tirthankar/core/keys.dart';
import 'package:Tirthankar/core/language.dart';
import 'package:Tirthankar/pages/youtube.dart';
import 'package:Tirthankar/widgets/common_methods.dart';
import 'package:Tirthankar/widgets/custom_buildDrawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// import 'widgets/meta_data_section.dart';
// import 'widgets/play_pause_button_bar.dart';
// import 'widgets/player_state_section.dart';
// import 'widgets/source_input_section.dart';
// import 'widgets/volume_slider.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(YoutubeApp());
// }

// class YoutubeApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Youtube Player IFrame Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//         iconTheme: const IconThemeData(color: Colors.deepPurpleAccent),
//       ),
//       debugShowCheckedModeBanner: false,
//       home: YoutubeAppDemo(),
//     );
//   }
// }

class YoutubeAppDemo extends StatefulWidget {
  String? id;
  String? appname;
  YoutubeAppDemo({this.id, this.appname});
  @override
  _YoutubeAppDemoState createState() => _YoutubeAppDemoState(id, appname);
}

class _YoutubeAppDemoState extends State<YoutubeAppDemo> {
  YoutubePlayerController? _controller;
  String? id;
  String? appname;
  bool _isDisposed = false;
  _YoutubeAppDemoState(this.id, this.appname);
  final common_methods commonmethod = new common_methods();
  final languageSelector selectlang = new languageSelector();

  @override
  void initState() {
    if (appname!.toUpperCase() == "JAIN RASOI") {
      currentappname = "VIDEO_JAIN RASOI";
    } else if (appname!.toUpperCase() == "KIDS") {
      currentappname = "VIDEO_KIDS";
    } else if (appname!.toUpperCase() == "PRAVCHAN") {
      currentappname = "VIDEO_PRAVCHAN";
    }

    // appname.contains("Live")
    //     ? WidgetsBinding.instance.addPostFrameCallback((_) => setup())
    //     : "";
    print("Playing - " + id!);
    _controller = YoutubePlayerController(
      initialVideoId: id!,
      params: const YoutubePlayerParams(
        autoPlay: true,
        startAt: const Duration(seconds: 01),
        showControls: true,
        showFullscreenButton: true,
      ),
    )..listen((event) {
        //log(event.toString());
      });

    _controller!.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      // Future.delayed(const Duration(seconds: 1), () {
      //   SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      // });
      log('Entered Fullscreen');
    };
    _controller!.onExitFullscreen = () {
      // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      Future.delayed(const Duration(seconds: 1), () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      });
      log('Exited Fullscreen');
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return WillPopScope(
      onWillPop: () {
        Route? route;
        if (appname!.toUpperCase() == "JAIN RASOI") {
          route = MaterialPageRoute(
            builder: (_) =>
                YoutubePlay(appname: "JAIN RASOI", search: "jain food recipe"),
          );
        } else if (appname!.toUpperCase() == "KIDS") {
          route = MaterialPageRoute(
            builder: (_) =>
                YoutubePlay(appname: "KIDS", search: "jain pathshala"),
          );
        } else if (appname!.toUpperCase() == "PRAVCHAN") {
          route = MaterialPageRoute(
            builder: (_) =>
                YoutubePlay(appname: "PRAVCHAN", search: currentMuni),
          );
        }
        Navigator.of(context).push(route!);
        throw "Failed to navigate youtube page";
      },
      child: YoutubePlayerControllerProvider(
        // Passing controller to widgets below.
        controller: _controller!,
        child: Scaffold(
          appBar: commonmethod.buildAppBar(context, "CALENDAR"),
          // GradientAppBar(
          //   elevation: 0,
          //   // backgroundColor: AppColors.styleColor,
          //   centerTitle: true,
          //   backgroundColorStart: Colors.red,
          //   backgroundColorEnd: Colors.purple,
          //   title: Text(
          //     selectlang.getAlbum("Tirthankar", lang_selection),
          //     style: TextStyle(color: AppColors.white),
          //   ),
          // ),
          drawer: new Drawer(child: CustomeBuildDrawer()),
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (kIsWeb && constraints.maxWidth > 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: player),
                    const SizedBox(
                      width: 500,
                      child: SingleChildScrollView(
                          // child: Controls(),
                          ),
                    ),
                  ],
                );
              }
              return ListView(
                children: [
                  player,
                  // const Controls(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller!.close();
    // _isDisposed = true;
    super.dispose();
  }
}
