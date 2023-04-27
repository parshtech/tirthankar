import 'dart:convert';
import 'dart:io';
// ignore: avoid_web_libraries_in_flutter
//import 'dart:html';

import 'package:Tirthankar/models/listdata.dart';
import 'package:Tirthankar/pages/books.dart';
import 'package:Tirthankar/pages/calendar.dart';
import 'package:Tirthankar/pages/ebooks.dart';
import 'package:Tirthankar/pages/home.dart';
import 'package:Tirthankar/pages/list_page_audio.dart';

// import 'package:Tirthankar/pages/list_page.txt';
import 'package:Tirthankar/pages/muni.dart';
import 'package:Tirthankar/pages/settings.dart';
import 'package:Tirthankar/pages/templelist.dart';
import 'package:Tirthankar/pages/unions.dart';
import 'package:Tirthankar/pages/youtube.dart';
import 'package:Tirthankar/pages/youtubeapi.dart';
import 'package:Tirthankar/widgets/custom_alert.dart';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
// import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/adapter.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import 'package:intl/intl.dart';
// import 'package:open_appstore/open_appstore.dart';
import 'package:package_info/package_info.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:Tirthankar/core/const.dart';
import 'package:flutter/material.dart';
import 'package:Tirthankar/core/dbmanager.dart';
import 'package:Tirthankar/core/keys.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as eos;
import 'package:Tirthankar/core/language.dart';
import 'package:Tirthankar/models/music.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:store_launcher/store_launcher.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class common_methods extends HttpOverrides {
  late String id;
  final sqllitedb dbHelper = new sqllitedb();
  final languageSelector selectlang = new languageSelector();

  // Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
  displayDialog(
      BuildContext context, String title, String message, Widget child) {
    // flutter defined function
    showDialog(
      barrierDismissible: true,
      // barrierColor: Colors.black.withOpacity(0.5),
      // transitionDuration: Duration(milliseconds: 700),
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });

        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: EdgeInsets.only(top: 5.0),
          backgroundColor: AppColors.styleColor,
          content: Container(
            height: 150,
            // margin: EdgeInsets.all(1.0),
            child: Align(
              alignment: Alignment.center,
              child: Column(children: <Widget>[
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 65),
                    child: Container(),
                  )
                ]),
                Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: new Text(
                      message,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ])
              ]),
            ),
          ),
          elevation: 50,
        );
      },
    );
  }

  Container buildImageBox(
      double sizew, double sizeh, double radius, String imagepath) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      width: sizew,
      height: sizeh,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        image: imagepath != null
            ? DecorationImage(
                fit: BoxFit.fill,
                image: ExactAssetImage(imagepath),
              )
            : null,
        border: Border.all(
          width: 1,
          color: AppColors.transperent,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.orange[50],
        //     blurRadius: 2,
        //     offset: Offset(2, 2),
        //     spreadRadius: 1,
        //   ),
        //   BoxShadow(
        //     color: Colors.orangeAccent,
        //     blurRadius: 2,
        //     offset: Offset(-2, -2),
        //     spreadRadius: 1,
        //   )
        // ],
      ),
    );
  }

  tileAction(BuildContext context, String modulename) {
    isInternet(context);
    Route? route;
    switch (modulename) {
      case "PRAVCHAN":
        route = MaterialPageRoute(
          builder: (_) => MuniPage(appname: modulename),
        );
        break;
      case "SETTING":
        route = MaterialPageRoute(
          builder: (_) => Settings(appname: modulename),
        );
        break;
      case "JAIN BOOKS":
        route = MaterialPageRoute(
          builder: (_) => BooksPage(appname: modulename),
        );
        break;
      case "VIDHAN":
        route = MaterialPageRoute(
          builder: (_) =>
              EbookPage(appname: modulename, imageurl: "assets/vidhan.png"),
        );
        break;
      case "JAIN POOJA":
        pujaChoise(context, modulename);
        break;
      case "JAIN RASOI":
        route = MaterialPageRoute(
          builder: (_) =>
              YoutubePlay(appname: "JAIN RASOI", search: "jain food recipe"),
        );
        break;
      case "CALENDAR":
        route = MaterialPageRoute(
          builder: (_) => CalendarPage(appname: "CALENDAR", month: 0),
        );
        break;
      case "JAIN TIRTH":
        route = MaterialPageRoute(
          builder: (_) => TemplePage(appname: "JAIN TIRTH"),
        );
        break;
      case "KIDS":
        kidsChoise(context, modulename);
        // route = MaterialPageRoute(
        //   builder: (_) =>
        //       YoutubePlay(appname: "KIDS", search: "jain pathshala"),
        // );
        break;
      case "JAIN GROUPS":
        route = MaterialPageRoute(
          builder: (_) => UnionsPage(appname: "JAIN GROUPS"),
        );
        // infoChoise(context, modulename);
        // route = MaterialPageRoute(
        //   builder: (_) =>
        //       YoutubePlay(appname: "KIDS", search: "jain pathshala"),
        // );
        break;
      case "JINVANI TV":
        launchURL(jinvaniId!.replaceAll(getDate() + "#", ""));
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (_) => YoutubeAppDemo(
        //       id: jinvaniId.replaceAll("https://www.youtube.com/watch?v=", ""),
        //       appname: "Jinvani Channel Live",
        //       // data: ndata,
        //     ),
        //   ),
        // );

        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (_) => YoutubePlay(
        //       appname: "Jinvani Channel",
        //       search: "Jinvani Channel Live",
        //     ),
        //   ),
        // );

        break;
      default:
        if (inuseAudioinfo != null) {
          if (inuseAudioinfo!.isPlaying == true ||
              inuseAudioinfo!.isPause == true) {
            if (inuseAudioinfo == null) {
              inuseAudioinfo = buildData(modulename.toUpperCase());
            }
          } else {
            inuseAudioinfo = null;
          }
        }
        if (modulename.contains("NAMOKAR")) {
          modulename = "DAILY";
        }
        route = MaterialPageRoute(
          builder: (_) => ListPage(appname: modulename.toUpperCase()),
        );
    }
    if (modulename != "JINVANI TV") {
      if (route != null) {
        Navigator.of(context).push(route);
      }
    }
  }

  kidsChoise(BuildContext context, String modulename) {
    var baseDialog = BaseAlertDialog(
        title: "Confirm Registration",
        content: "I Agree that the information provided is correct",
        child1: Icon(
          Icons.music_video,
          color: Colors.orange[300],
          size: 50,
        ),
        child2: Icon(
          Icons.ondemand_video,
          color: Colors.orange[300],
          size: 50,
        ),
        child1text: selectlang.getAlbum("MUSIC", lang_selection!),
        child2text: selectlang.getAlbum("VIDEO", lang_selection!),
        yesOnPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ListPage(
                appname: modulename.toUpperCase(),
                // data: ndata,
              ),
            ),
          );
        },
        noOnPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  YoutubePlay(appname: "KIDS", search: "jain pathshala"),
            ),
          );
        },
        yes: "Agree",
        no: "Cancel");
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
    // route = MaterialPageRoute(
    //   builder: (_) => EbookPage(appname: modulename),
    // );
  }

  infoChoise(BuildContext context, String modulename) {
    var baseDialog = BaseAlertDialog(
        title: "Confirm Registration",
        content: "I Agree that the information provided is correct",
        child1: Icon(
          Icons.people,
          color: Colors.orange[300],
          size: 50,
        ),
        child2: Icon(
          Icons.map,
          color: Colors.orange[300],
          size: 50,
        ),
        child1text: selectlang.getAlbum("KARYKARANI", lang_selection!),
        child2text: selectlang.getAlbum("JAIN TEMPLE SEARCH", lang_selection!),
        yesOnPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ListPage(
                appname: modulename.toUpperCase(),
                // data: ndata,
              ),
            ),
          );
        },
        noOnPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  YoutubePlay(appname: "KIDS", search: "jain pathshala"),
            ),
          );
        },
        yes: "Agree",
        no: "Cancel");
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
    // route = MaterialPageRoute(
    //   builder: (_) => EbookPage(appname: modulename),
    // );
  }

  pujaChoise(BuildContext context, String modulename) {
    var baseDialog = BaseAlertDialog(
        title: "Confirm Registration",
        content: "I Agree that the information provided is correct",
        child1: Icon(
          Icons.music_video,
          color: Colors.orange[300],
          size: 50,
        ),
        child2: Icon(
          Icons.book,
          color: Colors.orange[300],
          size: 50,
        ),
        child1text: selectlang.getAlbum("MUSIC", lang_selection!),
        child2text: selectlang.getAlbum("BOOK", lang_selection!),
        yesOnPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ListPage(
                appname: modulename.toUpperCase(),
                // data: ndata,
              ),
            ),
          );
        },
        noOnPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BooksPage(
                appname: modulename.toUpperCase(),
                // data: ndata,
              ),
            ),
          );
        },
        yes: "Agree",
        no: "Cancel");
    showDialog(context: context, builder: (BuildContext context) => baseDialog);
    // route = MaterialPageRoute(
    //   builder: (_) => EbookPage(appname: modulename),
    // );
  }

  Data buildData(String appname) {
    return Data(
        playId: inuseAudioinfo!.playId,
        songId: inuseAudioinfo!.songId,
        // inuseAudioinfo.audioPlayer: _inuseAudioinfo.audioPlayer,
        audioPlayer: inuseAudioinfo!.audioPlayer,
        isPause: inuseAudioinfo!.isPause,
        isPlaying: inuseAudioinfo!.isPlaying,
        isRepeat: inuseAudioinfo!.isRepeat,
        isShuffle: inuseAudioinfo!.isShuffle,
        // duration: _duration,
        // position: _position,
        duration: inuseAudioinfo!.duration,
        position: inuseAudioinfo!.position,
        title: inuseAudioinfo!.title,
        albumImage: moduleImage(appname),
        list: inuseAudioinfo!.list,
        appname: appname);
  }

  getYoutubeId(String query) async {
    List<YT_API>? ytResult = [];
    YoutubeAPIA ytApi = new YoutubeAPIA(YOUTUBE_KEY);
    // ytResult = await ytApi.search(query);
    if (internet != false) {
      ytResult = (await ytApi.searchVideo(query))!.cast<YT_API>();
      jinvaniId = getDate() + "#" + getLiveId(ytResult, query);
      setSharedPref('jinvaniId', jinvaniId!, 0);
      print(jinvaniId);
    }
    return jinvaniId;
  }

  getDate() {
    var newFormat = DateFormat("yy-MM-dd");
    String updatedDt = newFormat.format(DateTime.now());
    print(updatedDt);
    return updatedDt;
  }

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  NewGradientAppBar buildAppBar(BuildContext context, String appname) {
    return NewGradientAppBar(
      elevation: 0,
      // backgroundColor: AppColors.styleColor,
      centerTitle: true,
      gradient: LinearGradient(colors: [Colors.red, Colors.purple]),
      // backgroundColorStart: Colors.red,
      // backgroundColorEnd: Colors.purple,
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => HomePage(
                      appname: appname,
                      // data: ndata,
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.home,
                size: 26.0,
                color: Colors.white,
              ),
            )),
      ],
      title: Text(
        selectlang.getAlbum("Tirthankar", lang_selection!),
        style: TextStyle(color: AppColors.white),
      ),
    );
  }

  String moduleImage(String? modulename) {
    switch (modulename!.toUpperCase()) {
      case "AARTI":
        return "assets/diya.png";
        break;
      case "BHAKTAMBAR":
        return "assets/bhakt.png";
        break;
      case "KIDS":
        return "assets/story.png";
        break;
      case "JAIN POOJA":
        return "assets/pooja.png";
        break;
      case "BHAJAN":
        return "assets/bhajan.png";
        break;
      case "DAILY POOJA":
        return "assets/namokar.png";
        break;
      case "JAIN BOOKS":
        return "assets/ebook.png";
        break;
      case "VIDHAN":
        return "assets/vidhan.png";
        break;
      case "CHALISA":
        return "assets/chalisa.png";
        break;
      case "FAVORITE":
        return "assets/namokar.png";
        break;
      case "CALENDAR":
        return "assets/icon.png";
        break;
      case "JAIN RASOI":
        return "assets/jainrasoi.png";
        break;
      case "JINVANI TV":
        return "assets/jinvani.png";
        break;
      case "SETTING":
        return "assets/settings.png";
        break;
      case "JAIN GROUPS":
        return "assets/union.png";
        break;
      case "DIGAMBAR JAIN SAITWAL CENTRAL MEMBERS":
        return "assets/union.png";
        break;
      case "JAIN TIRTH":
        return "assets/temple.png";
        break;

      default:
    }
    throw "Module name is not set";
  }

  Future<void> downloadSongList(context, String appname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var date1;

    isLoading = true;
    bool firstinstall = false;
    dbversion = prefs.getInt('dbversion');
    downloadDate = prefs.getString('downloadDate');
    appversion = prefs.getString('appversion');
    // appversion = null;
    if (appversion == null) {
      appversion = currentAppVersion();
    }
    if ((downloadDate == null || downloadDate == "") || dbversion == null) {
      firstinstall = true;
      // isInternet(context);
      date1 = DateTime.now();
    } else {
      date1 = DateTime.parse(downloadDate!);
    }
    isInternet(context);

    final date2 = DateTime.now();
    final difference = date2.difference(date1).inDays;
    // if (difference == 0) {
    // _showVersionDialog(context);
    if (difference == 0 || firstinstall == true) {
      if (internet == false) {
        Toast.show(
            selectlang.getAlert("Check internet connection", lang_selection!),
            // context,
            duration: 1,
            gravity: 0);
        // displayDialog(
        //   context,
        //   "Internet Check",
        //   "No internter connection.",
        //   Icon(
        //     Icons.signal_wifi_off,
        //     size: 100,
        //     color: AppColors.red200,
        //   ),
        // );
      } else {
        // showLoaderDialog(context);
        // version = 0;
        eos.Response response;
        // String url = "https://www.parshtech.com/DATA/input.json";
        // "https://parshtech-songs-jainmusic.s3.us-east-2.amazonaws.com/input.json";
        String arrayObjsText = "";
        // '{ "version":1, "tags": [ { "id": 1, "title": "Namp 1", "album": "Flume", "songURL": "https://parshtech-songs-jainmusic.s3.us-east-2.amazonaws.com/Namokar/Namokaar+Mantra+by+Lata+Mangeshkar.mp3", "hindiName": "Testing 1", "favorite": false }, { "id": 2, "title": "Namp 2", "album": "Flume", "songURL": "https://parshtech-songs-jainmusic.s3.us-east-2.amazonaws.com/Namokar/Namokar+Mantra+by+Anurasdha+Paudwal.mp3", "hindiName": "Testing 1", "favorite": false }, { "id": 3, "title": "Namp 3", "album": "Flume", "songURL": "https://parshtech-songs-jainmusic.s3.us-east-2.amazonaws.com/Namokar/Namokaar+Mantra+by+Lata+Mangeshkar.mp3", "hindiName": "Testing 1", "favorite": false } ] }';
        // '{"tags": [{"name": "dart", "quantity": 12}, {"name": "flutter", "quantity": 25}, {"name": "json", "quantity": 8}]}';
        try {
          Dio dio = new Dio();
          (dio.httpClientAdapter as DefaultHttpClientAdapter)
              .onHttpClientCreate = (HttpClient dioClient) {
            dioClient.badCertificateCallback =
                ((X509Certificate cert, String host, int port) => true);
            return dioClient;
          };
          response = await dio.get(
            INPUT_FILE,
            options: Options(
              responseType: ResponseType.plain,
            ),
          );
          arrayObjsText = response.data;
          // print(response.data.toString());
          if (response != null) {
            final body = json.decode(response.data);
            var tagObjsJson = jsonDecode(arrayObjsText)['tags'] as List;
            var appvers = jsonDecode(arrayObjsText)['appversion'] as String;
            // appversion = null;
            if (appversion != appvers) {
              // _showVersionDialog(context);
            }
            songlist = tagObjsJson
                .map((tagJson) => MusicData.fromJson(tagJson))
                .toList();
            // dbversion = 1;
            if (dbversion == body['version']) {
              print("No DB update");
            } else {
              // dbHelper.batchInsertEventSongAsync(_list, body['version']);
              dbHelper.buildDB1(songlist!, body['version']);
            }
          }

          // Navigator.of(context, rootNavigator: false).pop();
          // Navigator.pop(context);
        } catch (e) {
          // Navigator.of(context, rootNavigator: false).pop();
          // Navigator.pop(context);
          displayDialog(
            context,
            "Error",
            "Donwload Failed..",
            Icon(
              Icons.signal_wifi_off,
              size: 100,
              color: AppColors.red200,
            ),
          );
          print(e);
        }
      }
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Downloading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> isInternet(BuildContext context) async {
    if (kIsWeb) {
      // running on the web!
      internet = true;
      return true;
    } else {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network, make sure there is actually a net connection.
        if (await DataConnectionChecker().hasConnection) {
          // Mobile data detected & internet connection confirmed.
          internet = true;
          return true;
        } else {
          // Mobile data detected but no internet connection found.
          noInternet(context);
          internet = false;
          return false;
        }
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a WIFI network, make sure there is actually a net connection.
        if (await DataConnectionChecker().hasConnection) {
          // Wifi detected & internet connection confirmed.
          internet = true;
          return true;
        } else {
          // Wifi detected but no internet connection found.
          noInternet(context);
          internet = false;
          return false;
        }
      } else {
        // Neither mobile data or WIFI detected, not internet connection found.
        noInternet(context);
        internet = false;
        return false;
      }
    }
  }

  noInternet(BuildContext context) {
    Toast.show(
        selectlang.getAlert("Check internet connection", lang_selection!),
        // context,
        duration: 1,
        gravity: 0);
    // displayDialog(
    //   context,
    //   "Internet Check",
    //   selectlang.getAlert("Check internet connection", lang_selection!),
    //   Icon(
    //     Icons.signal_wifi_off,
    //     size: 100,
    //     color: AppColors.red200,
    //   ),
    // );
  }

  // AppBar buildAppBar() {
  //   return AppBar(
  //     elevation: 0,
  //     backgroundColor: AppColors.styleColor,
  //     centerTitle: true,
  //     title: Text(
  //       selectlang.getAlbum("Tirthankar", lang_selection!),
  //       style: TextStyle(color: AppColors.white),
  //     ),
  //   );
  // }

  Future<void> getSharedPref(String variable) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (variable) {
      case "language":
        lang_selection = prefs.getInt('language') ?? 1;
        print(lang_selection);
        break;
      case "downloadDate":
        downloadDate = (prefs.getString('downloadDate') ?? 0) as String?;
        if (downloadDate == null) {
          final date2 = DateTime.now();
          downloadDate = date2.toString();
          setSharedPref('downloadDate', downloadDate!, 0);
        }
        print(downloadDate);
        break;
      case "jinvaniId":
        jinvaniId = (prefs.getString('jinvaniId') ?? 0) as String?;
        if (jinvaniId == null || jinvaniId != 0) {
          getYoutubeId("Jinvani Channel Live");
          setSharedPref('jinvaniId', jinvaniId!, 0);
        }
        print(jinvaniId);
        break;
      case "":
        lang_selection = prefs.getInt('language') ?? 1;
        downloadDate = prefs.getString('downloadDate');
        // downloadDate = ((DateTime.now()).toString()).replaceAll("30", "29");
        if (downloadDate == null) {
          final date2 = DateTime.now();
          downloadDate = date2.toString();
          setSharedPref('downloadDate', downloadDate!, 0);
        }
        jinvaniId = prefs.getString('jinvaniId') ?? "";
        if (jinvaniId == null ||
            jinvaniId == "" ||
            !jinvaniId!.contains(getDate())) {
          getYoutubeId("Jinvani Channel Live");
          setSharedPref('jinvaniId', jinvaniId!, 0);
        }
        print(lang_selection);
        print(downloadDate);
        print(jinvaniId);
        break;
      default:
        lang_selection = prefs.getInt('language') ?? 0;
        downloadDate = prefs.getString('downloadDate');
        if (downloadDate == null) {
          final date2 = DateTime.now();
          setSharedPref('downloadDate', date2.toString(), 0);
          downloadDate = date2.toString();
        }
        print(lang_selection);
        print(downloadDate);
    }
  }

  Future<void> setSharedPref(
      String variable, String downloadDate, int lang) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (variable) {
      case "language":
        prefs.setInt('language', lang);
        lang_selection = lang;
        break;
      case "downloadDate":
        prefs.setString('downloadDate', downloadDate);
        downloadDate = downloadDate;
        break;
      case "jinvaniId":
        prefs.setString('jinvaniId', downloadDate);
        downloadDate = downloadDate;
        break;
      case "appversion":
        prefs.setString('appversion', downloadDate);
        appversion = downloadDate;
        break;
      default:
    }
  }

  getLiveId(List<YT_API> ytResult, String appname) {
    for (int i = 0; i < ytResult.length; i++) {
      if (ytResult[i].liveBroadcastContent == "live") {
        return (ytResult[i].url)!.replaceAll(" ", "");
      }
    }
  }

  Future<String> currentAppVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    String currentVersion = info.version.trim();
    // double.parse(info.version.trim().replaceAll(".", ""));
    setSharedPref('appversion', currentVersion.toString(), 0);
    appversion = currentVersion;
    return currentVersion;
  }

  // versionCheck(context) async {
  //   //Get Current installed version of app
  //   final PackageInfo info = await PackageInfo.fromPlatform();
  //   double currentVersion =
  //       double.parse(info.version.trim().replaceAll(".", ""));

  //   //Get Latest version info from firebase config
  //   final RemoteConfig remoteConfig = await RemoteConfig.instance;

  //   try {
  //     // Using default duration to force fetching from remote server.
  //     await remoteConfig.fetch(expiration: const Duration(seconds: 0));
  //     await remoteConfig.activateFetched();
  //     remoteConfig.getString('force_update_current_version');
  //     double newVersion = double.parse(remoteConfig
  //         .getString('force_update_current_version')
  //         .trim()
  //         .replaceAll(".", ""));
  //     if (newVersion > currentVersion) {
  //       _showVersionDialog(context);
  //     }
  //   } on FetchThrottledException catch (exception) {
  //     // Fetch throttled.
  //     print(exception);
  //   } catch (exception) {
  //     print('Unable to fetch remote config. Cached or default values will be '
  //         'used');
  //   }
  // }

  _showVersionDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "New Update Available";
        String message =
            "There is a newer version of app available please update it now.";
        String btnLabel = "Update Now";
        String btnLabelCancel = "Later";
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  TextButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(APP_STORE_URL),
                  ),
                  TextButton(
                    child: Text(btnLabelCancel),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              )
            : new AlertDialog(
                title: Text(title),
                content: Text(message),
                actions: <Widget>[
                  TextButton(
                    child: Text(btnLabel),
                    onPressed: () => _launchURL(PLAY_STORE_URL),
                  ),
                  TextButton(
                    child: Text(btnLabelCancel),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
      },
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchCaller(number) async {
    String url = "tel:" + number;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  launchMaps(String lat, String lon, String address) async {
    if ((lat != null && lat != 0 && lat != 'NA' && lat != '') &&
        (lon != null && lon != 0 && lon != 'NA' && lon != '')) {
      final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
      if (await canLaunch(url)) {
        debugPrint("Launching LAT LONG");
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } else if (address != null && address != 'NA' && address != '') {
      final url =
          'https://www.google.com/maps/search/${Uri.encodeFull(address)}';
      if (await canLaunch(url)) {
        debugPrint("Launching Address");
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  launchEmail(email) {
    if (email != null && email != 'NA' && email != '') {
      final Uri _emailLaunchUri = Uri(
          scheme: 'mailto',
          path: email,
          queryParameters: {'subject': 'Tirthankar App Generated Email!'});

// ...

// mailto:smith@example.com?subject=Example+Subject+%26+Symbols+are+allowed%21
      launch(_emailLaunchUri.toString());
    }
  }

  filterMobile(mobile) {
    List<String> phone = mobile.split(",");
    return phone;
  }

  phonePopup(context, phone) {
    if (phone != null && phone.length > 0) {
      // setupAlertDialoadContainer(context, phone);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                  selectlang.getAlbum("CHOOSE PHONE NUMBER", lang_selection!)),
              content: Container(
                height: 300.0, // Change as per your requirement
                width: 300.0, // Change as per your requirement

                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: phone == null ? 0 : phone.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pop();
                        _launchCaller(phone[index].toString());
                      },
                      leading: Icon(
                        Icons.call,
                        color: Colors.brown,
                      ),
                      title: Text(phone[index].toString()),
                    );
                  },
                ),
              ),
            );
          });
    }
  }

  Widget setupAlertDialoadContainer(phone) {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement

      child: ListView.builder(
        shrinkWrap: true,
        itemCount: phone == null ? 0 : phone.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: _launchCaller(phone[index].toString()),
            title: Text(phone[index].toString()),
          );
        },
      ),
    );
  }
}
