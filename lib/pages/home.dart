import 'dart:async';
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:Tirthankar/core/const.dart';
import 'package:Tirthankar/core/dbmanager.dart';
import 'package:Tirthankar/core/keys.dart';
import 'package:Tirthankar/core/language.dart';
import 'package:Tirthankar/models/listdata.dart';
import 'package:Tirthankar/models/music.dart';
import 'package:Tirthankar/pages/books.dart';
import 'package:Tirthankar/pages/calendar.dart';
import 'package:Tirthankar/pages/ebooks.dart';
import 'package:Tirthankar/pages/list_page_audio.dart';
import 'package:Tirthankar/pages/muni.dart';
import 'package:Tirthankar/pages/unions.dart';
import 'package:Tirthankar/pages/youtube.dart';
import 'package:Tirthankar/widgets/custom_buildDrawer.dart';
// ignore: unused_import
import 'package:Tirthankar/pages/youtubeapi.dart';
import 'package:Tirthankar/widgets/common_methods.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:youtube_api/youtube_api.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  // int playingId;
  // Data data;
  String? appname;

  // List<MusicData> list;
  // HomePage({this.appname, this.data});
  HomePage({this.appname});
  @override
  _HomePageState createState() => _HomePageState(appname);
}

class _HomePageState extends State<HomePage> {
  String? appname;
  late Data data;
  late int lang_index;
  late bool isUpdating;
  late List<MusicData> _list;
  final sqllitedb dbHelper = new sqllitedb();
  final languageSelector selectlang = new languageSelector();
  final common_methods commonmethod = new common_methods();
  // bool isLoading = false;

  // final DBHelper dbHelper = new DBHelper();
  // int playingId = 0;

  // List<MusicData> list;
  _HomePageState(this.appname);
  // print('${playingId}');

  @override
  void initState() {
    // isLoading = false;
    currentappname = "HomePage";
    appname = "";
    // if (jinvaniId == null || jinvaniId != "") {
    //   commonmethod.getYoutubeId("Jinvani Channel Live");
    // }

    // commonmethod.isInternet(context);
    // // isInternet();
    // commonmethod.downloadSongList(context, appname);
    // commonmethod.getSharedPref("").whenComplete(() => setState(() {
    //       lang_selection = lang_selection;
    //       downloadDate = downloadDate;
    //     }));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setup();
      // isLoading = false;
    });
  }

  setup() async {
    print("Loading");
    isLoading = true;
    lang_selection = 0;
    commonmethod
        .getSharedPref("")
        .whenComplete(() => setState(() {
              lang_selection = lang_selection;
              downloadDate = downloadDate;
              jinvaniId = jinvaniId;
            }))
        .then((value) => isLoading = false);
    commonmethod.isInternet(context);
    var status = await Permission.storage.status;
    var locationst = await Permission.location.status;
    if (!status.isGranted || !locationst.isGranted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
      Future.delayed(Duration(seconds: 5), () => CircularProgressIndicator());
      print(statuses[Permission.location]);
      // await Permission.storage.request();
    }

    // isInternet();
    if (!kIsWeb) {
      if (homefolder == null) {
        homefolder = getHomeFolder();
      }

      commonmethod
          .downloadSongList(context, appname!)
          .then((value) => isLoading = false);
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
    var myImageAndCaption;

    if (kIsWeb) {
      myImageAndCaption = [
        ["assets/diya.png", "AARTI"],
        // ["assets/bhakt.png", "Bhaktambar"],
        ["assets/story.png", "KIDS"],
        ["assets/bhajan.png", "BHAJAN"],
        // ["assets/namokar.png", "NAMOKAR"],
        ["assets/vidyasagar.png", "PRAVCHAN"],
        ["assets/ebook.png", "JAIN BOOKS"],
        ["assets/jainrasoi.png", "JAIN RASOI"],
        ["assets/chalisa.png", "CHALISA"],
        ["assets/namokar.png", "FAVORITE"],
        // ["assets/vidhan.png", "VIDHAN"],
        ["assets/pooja.png", "JAIN POOJA"],
        ["assets/jinvani.png", "JINVANI TV"],
        ["assets/calendar/icon.png", "CALENDAR"],
        ["assets/locations.png", "JAIN GROUPS"],
        ["assets/temple.png", "JAIN TIRTH"],
        // ["assets/magazine.png", "JAIN MAGAZINE"],
        ["assets/settings.png", "SETTING"]
      ];
    } else {
      myImageAndCaption = [
        ["assets/diya.png", "AARTI"],
        // ["assets/bhakt.png", "Bhaktambar"],
        ["assets/story.png", "KIDS"],
        ["assets/bhajan.png", "BHAJAN"],
        // ["assets/namokar.png", "NAMOKAR"],
        ["assets/vidyasagar.png", "PRAVCHAN"],
        ["assets/ebook.png", "JAIN BOOKS"],
        ["assets/jainrasoi.png", "JAIN RASOI"],
        ["assets/chalisa.png", "CHALISA"],
        ["assets/namokar.png", "FAVORITE"],
        // ["assets/vidhan.png", "VIDHAN"],
        ["assets/pooja.png", "JAIN POOJA"],
        ["assets/jinvani.png", "JINVANI TV"],
        ["assets/calendar/icon.png", "CALENDAR"],
        ["assets/locations.png", "JAIN GROUPS"],
        ["assets/temple.png", "JAIN TIRTH"],
        // ["assets/magazine.png", "JAIN MAGAZINE"],
        ["assets/settings.png", "SETTING"]
      ];
    }

    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeLeft,
      // DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        // Future.value(false);
        // _showToast(context);
        _onBackPressed();
        throw "Unable to load on backpress";
      },
      child: MaterialApp(
        title: 'Tirthankar',
        home: Scaffold(
          appBar: NewGradientAppBar(
            elevation: 0,
            // backgroundColor: AppColors.styleColor,
            centerTitle: true,
            gradient: LinearGradient(colors: [Colors.red, Colors.purple]),
            // backgroundColorStart: Colors.red,
            // backgroundColorEnd: Colors.purple,
            title: Text(
              selectlang.getAlbum("Tirthankar", lang_selection),
              style: TextStyle(color: AppColors.white),
            ),
          ),
          drawer: new Drawer(child: CustomeBuildDrawer()),
          backgroundColor: AppColors.mainColor,
          floatingActionButton:
              (inuseAudioinfo != null && inuseAudioinfo!.list != null)
                  ? buildMusicFAB()
                  : null,
          // child: new StaggeredGridView.countBuilder(
          body: Container(
            margin: EdgeInsets.all(12),
            child: new MasonryGridView.count(
              crossAxisCount: kIsWeb ? 4 : 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 15,
              shrinkWrap: true,
              itemCount: myImageAndCaption.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    commonmethod.tileAction(
                        context, myImageAndCaption[index][1]);
                    print("Container clicked" + myImageAndCaption[index][1]);
                  },
                  child: Container(
                    height: 140,
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
                            flex: 2,
                            child: Text(
                              selectlang.getAlbum(
                                  myImageAndCaption[index][1], lang_selection!),
                              style: TextStyle(fontSize: 15),
                            )),
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
              // staggeredTileBuilder: (index) {
              //   // return new StaggeredTile.count(1, index.isEven ? 1 : 1);
              //   return new StaggeredTile.count(1, 1);
              // }
            ),
          ),
        ),
      ),
    );
  }

  void listBackPress() {
    // if (inuseAudioinfo.isPlaying == true || inuseAudioinfo.isPause == true) {
    //   if (inuseAudioinfo == null) {
    //     inuseAudioinfo = buildData();
    //   }
    // } else {
    //   inuseAudioinfo = null;
    // }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ListPage(
          appname: currentMuni,
          // data: ndata,
        ),
      ),
    );
  }

  Future _onBackPressed() {
    String? appname;
    if (currentappname!.startsWith("VIDEO_")) {
      appname = currentappname!.replaceAll("VIDEO_", "");
      currentappname = "VIDEO";
    }
    switch (currentappname) {
      case "LISTPAGE":
        currentappname = null;
        listBackPress();
        break;
      case ("HOME"):
        currentappname = null;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => HomePage(
              appname: "HomePage",
              // data: ndata,
            ),
          ),
        );
        break;
      case ("UNIONS"):
        currentappname = null;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => UnionsPage(
              appname: "UNION",
              // data: ndata,
            ),
          ),
        );
        break;
      case "BOOKS":
        currentappname = null;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BooksPage(appname: "BOOKS"),
          ),
        );
        break;
      case "JAIN BOOKS":
        currentappname = null;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EbookPage(
              appname: "JAIN BOOKS",
              list: booklist,
              // data: ndata,
            ),
          ),
        );
        break;
      case "VIDHAN":
        currentappname = null;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EbookPage(
              appname: "VIDHAN",
              // data: ndata,
            ),
          ),
        );
        break;
      case "JAIN POOJA":
        currentappname = null;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => EbookPage(appname: "JAIN POOJA"
                // data: ndata,
                ),
          ),
        );
        break;
      case "CALENDAR":
        currentappname = null;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CalendarPage(appname: "CALENDAR", month: curmonth),
          ),
        );
        break;
      case "PRAVCHAN":
        currentappname = null;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MuniPage(
              appname: "Pravchan",
              // data: ndata,
            ),
          ),
        );
        break;
      case "VIDEO":
        if (appname!.toUpperCase() == "JAIN RASOI") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => YoutubePlay(
                  appname: "JAIN RASOI", search: "jain food recipe"),
            ),
          );
        } else if (appname.toUpperCase() == "KIDS") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  YoutubePlay(appname: "KIDS", search: "jain pathshala"),
            ),
          );
        } else if (appname.toUpperCase() == "PRAVCHAN") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => YoutubePlay(
                appname: "Pravchan",
                search: currentMuni!,
              ),
            ),
          );
        }

        break;
      case "HomePage":
        currentappname = null;
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Are you sure?'),
                content: Text('You are going to exit the application!!'),
                actions: <Widget>[
                  TextButton(
                    child: Text('NO'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: Text('YES'),
                    onPressed: () {
                      SystemNavigator.pop();
                      // Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            });
        break;
      default:
        currentappname = null;
        Navigator.of(context, rootNavigator: true).pop(context);
        // Navigator.pop(context);
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (_) => HomePage(
        //       appname: appname,
        //       // data: ndata,
        //     ),
        //   ),
        // );
        break;
    }
    throw "Failed to create backpress navigator";
  }

  Padding buildMusicFAB() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: FloatingActionButton(
        child: Icon(
          inuseAudioinfo!.isPlaying! ? Icons.pause : Icons.play_arrow,
        ),
        onPressed: () {
          if (inuseAudioinfo!.isPlaying!) {
            setState(() {
              inuseAudioinfo!.audioPlayer!.pause();
              inuseAudioinfo!.isPlaying = false;
              inuseAudioinfo!.isPause = true;
            });
          } else if (inuseAudioinfo!.isPause!) {
            setState(() {
              // inuseAudioinfo.audioPlayer.resume();
              inuseAudioinfo!.audioPlayer!.play();
              inuseAudioinfo!.isPlaying = true;
              inuseAudioinfo!.isPause = false;
            });
          } else if (inuseAudioinfo!.songId != null) {
            setState(() {
              // inuseAudioinfo.audioPlayer.resume();
              inuseAudioinfo!.audioPlayer!.play();
              inuseAudioinfo!.isPlaying = true;
              inuseAudioinfo!.isPause = false;
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

  // @override
  // void dipose() {
  //   super.dispose();
  // }

  Future<void> getHomeFolder() async {
    var dir;
    if (io.Platform.isAndroid) {
      dir = await getExternalStorageDirectory();
      // tempDir = "/sdcard/download/";
    } else if (io.Platform.isIOS) {
      dir = getApplicationDocumentsDirectory();
    }
    setState(() {
      homefolder = dir;
    });
    return dir;
  }
}
