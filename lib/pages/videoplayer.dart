// Copyright 2020 Sarbagya Dhaubanjar. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:developer';

import 'package:Tirthankar/core/const.dart';
import 'package:Tirthankar/core/keys.dart';
import 'package:Tirthankar/pages/youtubeapi.dart';
import 'package:Tirthankar/widgets/common_methods.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String id;
  String appname;
  YoutubeAppDemo({this.id, this.appname});
  @override
  _YoutubeAppDemoState createState() => _YoutubeAppDemoState(id, appname);
}

class _YoutubeAppDemoState extends State<YoutubeAppDemo> {
  YoutubePlayerController _controller;
  String id;
  String appname;
  bool _isDisposed = false;
  _YoutubeAppDemoState(this.id, this.appname);
  final common_methods commonmethod = new common_methods();

  @override
  void initState() {
    super.initState();
    // appname.contains("Live")
    //     ? WidgetsBinding.instance.addPostFrameCallback((_) => setup())
    //     : "";
    _controller = YoutubePlayerController(
      initialVideoId: id,
      params: const YoutubePlayerParams(
        autoPlay: true,
        startAt: const Duration(seconds: 30),
        showControls: true,
        showFullscreenButton: true,
      ),
    )..listen((event) {
        //log(event.toString());
      });
      

    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
      // Future.delayed(const Duration(seconds: 1), () {
      //   SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      // });
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      Future.delayed(const Duration(seconds: 1), () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      });
      log('Exited Fullscreen');
    };
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      // Passing controller to widgets below.
      controller: _controller,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.styleColor,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          title: Text(
            "Tirthankar",
            style: TextStyle(color: Colors.white),
          ),
        ),
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
    );
  }

  @override
  void dispose() {
    _controller.close();
    // _isDisposed = true;
    super.dispose();
  }
}
