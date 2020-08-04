import 'dart:async';
import 'package:Tirthankar/widgets/custom_buildDrawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:Tirthankar/core/const.dart';
import 'package:Tirthankar/core/dbmanager.dart';
import 'package:Tirthankar/core/keys.dart';
import 'package:Tirthankar/core/language.dart';
import 'package:Tirthankar/models/listdata.dart';
import 'package:Tirthankar/models/music.dart';
// import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

// ignore: unused_import
import 'package:Tirthankar/pages/youtubeapi.dart';
import 'package:Tirthankar/widgets/common_methods.dart';
import 'package:Tirthankar/widgets/custome_tilebuilder.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:youtube_api/youtube_api.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  // int playingId;
  // Data data;
  String appname;

  // List<MusicData> list;
  // HomePage({this.appname, this.data});
  HomePage({this.appname});
  @override
  _HomePageState createState() => _HomePageState(appname);
}

class _HomePageState extends State<HomePage> {
  String appname;
  Data data;
  int lang_index;
  bool isUpdating;
  List<MusicData> _list;
  final sqllitedb dbHelper = new sqllitedb();
  final languageSelector selectlang = new languageSelector();
  final common_methods commonmethod = new common_methods();
  bool isLoaded = false;

  // final DBHelper dbHelper = new DBHelper();
  // int playingId = 0;

  // List<MusicData> list;
  _HomePageState(this.appname);
  // print('${playingId}');

  @override
  void initState() {
    appname = "";
    if (jinvaniId == null || jinvaniId != "") {
      commonmethod.getYoutubeId("Jinvani Channel Live");
    }

    // commonmethod.isInternet(context);
    // // isInternet();
    // commonmethod.downloadSongList(context, appname);
    // commonmethod.getSharedPref("").whenComplete(() => setState(() {
    //       lang_selection = lang_selection;
    //       downloadDate = downloadDate;
    //     }));
    WidgetsBinding.instance.addPostFrameCallback((_) => setup());
  }

  setup() {
    commonmethod.getSharedPref("").whenComplete(() => setState(() {
          lang_selection = lang_selection;
          downloadDate = downloadDate;
        }));
    commonmethod.isInternet(context);
    // isInternet();
    if (!kIsWeb) {
      commonmethod.downloadSongList(context, appname);
    }
  }

  @override
  void setState(fn) {
    // commonmethod.getSharedPref("").whenComplete(() => setState(() {
    //       lang_selection = lang_selection;
    //       downloadDate = downloadDate;
    //     }));
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final myImageAndCaption = [
      ["assets/diya.png", "Aarti"],
      // ["assets/bhakt.png", "Bhaktambar"],
      ["assets/story.png", "Kids"],
      ["assets/bhajan.png", "Bhajan"],
      ["assets/namokar.png", "Daily Pooja"],
      ["assets/vidyasagar.png", "Pravchan"],
      ["assets/chalisa.png", "Chalisa"],
      ["assets/jinvani.png", "Jinvani Channel"],
      ["assets/jainrasoi.png", "Jain Rasoi"],
      ["assets/aug_row_4_col_1.png", "Calendar"],
      ["assets/favorite.png", "Favorite"],
      ["assets/settings.png", "Setting"]
    ];
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeLeft,
      // DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      title: 'Tirthankar',
      home: Scaffold(
        appBar: GradientAppBar(
          elevation: 0,
          // backgroundColor: AppColors.styleColor,
          centerTitle: true,
          backgroundColorStart: Colors.red,
          backgroundColorEnd: Colors.purple,
          title: Text(
            selectlang.getAlbum("Tirthankar", lang_selection),
            style: TextStyle(color: AppColors.white),
          ),
        ),
        drawer: new Drawer(child: CustomeBuildDrawer()),
        backgroundColor: AppColors.mainColor,
        floatingActionButton: inuseAudioinfo != null ? buildMusicFAB() : null,
        body: Container(
          margin: EdgeInsets.all(12),
          child: new StaggeredGridView.countBuilder(
              crossAxisCount: kIsWeb ? 3 : 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              itemCount: myImageAndCaption.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    commonmethod.tileAction(
                        context, myImageAndCaption[index][1]);
                    print("Container clicked" + myImageAndCaption[index][1]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 9,
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              child: Image.asset(myImageAndCaption[index][0],
                                  fit: BoxFit.fill)),
                        ),
                        Expanded(
                            flex: 2, child: Text(myImageAndCaption[index][1])),
                      ],
                    ),
                  ),
                  // child: Container(
                  //     decoration: BoxDecoration(
                  //         color: Colors.transparent,
                  //         borderRadius: BorderRadius.all(Radius.circular(12))),
                  //     child: ClipRRect(
                  //         borderRadius: BorderRadius.all(Radius.circular(12)),
                  //         child: CustomTileBuilder(
                  //             imagepath: myImageAndCaption[index][0],
                  //             name: selectlang.getAlbum(
                  //                 myImageAndCaption[index][1],
                  //                 lang_selection)))),
                );
              },
              staggeredTileBuilder: (index) {
                return new StaggeredTile.count(1, index.isEven ? 1 : 0.9);
              }),
        ),
      ),
    );
  }

  Padding buildMusicFAB() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: FloatingActionButton(
        child: Icon(
          inuseAudioinfo.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
        onPressed: () {
          if (inuseAudioinfo.isPlaying) {
            setState(() {
              inuseAudioinfo.audioPlayer.pause();
              inuseAudioinfo.isPlaying = false;
              inuseAudioinfo.isPause = true;
            });
          } else if (inuseAudioinfo.isPause) {
            setState(() {
              // inuseAudioinfo.audioPlayer.resume();
              inuseAudioinfo.audioPlayer.play();
              inuseAudioinfo.isPlaying = true;
              inuseAudioinfo.isPause = false;
            });
          }
        },
      ),
    );
  }

  Future<bool> loginAction() async {
    //replace the below line of code with your login request
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await new Future.delayed(const Duration(seconds: 2));
    localPref = prefs;
    return true;
  }
}
