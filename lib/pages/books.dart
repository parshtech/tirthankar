// import 'dart:js';

import 'dart:async';

//import 'dart:ffi';

// import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:Tirthankar/core/language.dart';
import 'package:Tirthankar/models/music.dart';
import 'package:Tirthankar/pages/ebooks.dart';
import 'package:Tirthankar/widgets/custom_buildDrawer.dart';

// import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:Tirthankar/core/const.dart';
import 'package:Tirthankar/core/dbmanager.dart';
import 'package:Tirthankar/core/keys.dart';
// import 'package:ext_storage/ext_storage.dart';
import 'package:Tirthankar/widgets/common_methods.dart';
import 'package:dio/adapter.dart';
// import 'package:inuseAudioinfo.audioPlayer/inuseAudioinfo.audioPlayer.dart';
import 'package:flutter/material.dart';
import 'package:Tirthankar/pages/home.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as eos;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:toast/toast.dart';

class BooksPage extends StatefulWidget {
  String? appname;
  BooksPage({this.appname});
  @override
  _BooksPageState createState() => _BooksPageState(appname!);
}

class _BooksPageState extends State<BooksPage>
    with SingleTickerProviderStateMixin {
  String appname;
  // Data data;

  _BooksPageState(this.appname); // List<MusicModel> _list1;
  final sqllitedb dbHelper = new sqllitedb();
  final languageSelector selectlang = new languageSelector();
  final common_methods commonmethod = new common_methods();
  List<MusicData>? _list;
  List<MusicData>? _filelist;
  int? downloadId;
  // var tempDir;
  var dio = Dio();
  String downloadPerc = "0";
  bool isDownloading = false;

  // AudioPlayerState playerState;
  @override
  void initState() {
    currentappname = "HOME";
    // data = inuseAudioinfo;
    // downloadUnionList(appname);

    // getFilePath();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setup();
      // isLoading = false;
    });
    super.initState();
  }

  setup() async {
    print("Loading");
    isLoading = true;
    downloadSongList(appname).then((value) => isLoading = false);
    Future.delayed(Duration(seconds: 5), () => CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          currentappname = null;
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => HomePage(
                appname: "HomePage",
                // data: ndata,
              ),
            ),
          );
          throw "Uanble to build widget";
        },
        child: Scaffold(
          appBar: commonmethod.buildAppBar(context, appname),
          drawer: new Drawer(child: CustomeBuildDrawer()),
          backgroundColor: AppColors.mainColor,
          // body: Container(
          //   padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
          //   height: 100,
          //   width: double.maxFinite,
          //   color: AppColors.mainColor,

          body: (_filelist != null && _filelist!.length > 0)
              ? ListView.builder(
                  itemCount: _filelist!.length,
                  itemBuilder: (context, index) {
                    return buildCard(index);
                    // return ListTile(
                    //   title: Text('${items[index]}'),
                    // );
                  },
                )
              : Center(child: CircularProgressIndicator(strokeWidth: 10)),

          // child: <Widget>[
          //   buildCard("DIGAMBAR JAIN SAITWAL CENTRAL MEMBERS"),
          //   buildCard("DIGAMBAR JAIN SAITWAL CENTRAL MEMBERS")
          // ],
          // ),
        ));
  }

  Card buildCard(int index) {
    return Card(
      color: AppColors.mainColor,
      child: ListTile(
        onTap: () {
          _list = filterdata(_filelist![index].album);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => EbookPage(
                  appname: appname,
                  list: _list,
                  imageurl: _filelist![index].songURL),
            ),
          );
        },
        leading: Image.asset(_filelist![index].songURL),
        title: Text((lang_selection == 0 || lang_selection == null)
            ? _filelist![index].title
            : _filelist![index].mname),
      ),
    );
  }

  Container buildHeader(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * (kIsWeb ? 0.1 : 0.2),
      width: MediaQuery.of(context).size.width * (kIsWeb ? 0.1 : 0.2),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(commonmethod.moduleImage(appname)),
          fit: BoxFit.fill,
        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
    );
  }

  void onbackPress() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => HomePage(
          appname: appname,
          // data: ndata,
        ),
      ),
    );
  }

  // String getLangText(String s) {
  //   if (lang_selection == 0 || lang_selection == null) {
  //     return s;
  //   } else {
  //     return "अखिल दिगंबर जैन सैतवाल संस्था केंद्रीय कार्यकारिणी";
  //   }
  // }

  Future<List<MusicData>> downloadSongList(String appname) async {
    // String url = "https://parshtech-songs-jainmusic.s3.us-east-2.amazonaws.com/input.json";
    String arrayObjsText = "";
    // '{ "version":1, "tags": [ { "id": 1, "title": "Namp 1", "album": "Flume", "songURL": "https://parshtech-songs-jainmusic.s3.us-east-2.amazonaws.com/Namokar/Namokaar+Mantra+by+Lata+Mangeshkar.mp3", "hindiName": "Testing 1", "favorite": false }, { "id": 2, "title": "Namp 2", "album": "Flume", "songURL": "https://parshtech-songs-jainmusic.s3.us-east-2.amazonaws.com/Namokar/Namokar+Mantra+by+Anurasdha+Paudwal.mp3", "hindiName": "Testing 1", "favorite": false }, { "id": 3, "title": "Namp 3", "album": "Flume", "songURL": "https://parshtech-songs-jainmusic.s3.us-east-2.amazonaws.com/Namokar/Namokaar+Mantra+by+Lata+Mangeshkar.mp3", "hindiName": "Testing 1", "favorite": false } ] }';
    // '{"tags": [{"name": "dart", "quantity": 12}, {"name": "flutter", "quantity": 25}, {"name": "json", "quantity": 8}]}';
    try {
      eos.Response response;
      Dio dio = new Dio();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      response = await dio.get(
        EBOOK_FILE,
        options: Options(
          responseType: ResponseType.plain,
        ),
      );
      // _list = response.data;
      arrayObjsText = response.data;
      // arrayObjsText = response.data.toString();
      // print(response.data.toString());
    } catch (e) {
      print(e);
    }
    if (arrayObjsText != "") {
      var booktypeObjsJson =
          convert.jsonDecode(arrayObjsText)['booktype'] as List;
      var tagObjsJson = convert.jsonDecode(arrayObjsText)['tags'] as List;
      this.setState(() {
        _filelist = booktypeObjsJson
            .map((tagJson) => MusicData.fromJson(tagJson))
            .toList();
        _list =
            tagObjsJson.map((tagJson) => MusicData.fromJson(tagJson)).toList();
        if (_list!.length > 0) {
          print(_list!.length);
        } else {
          Toast.show(
              selectlang.getAlert("Check internet connection", lang_selection!),
              duration: 1,
              gravity: 0);
        }
      });
    }
    throw "error getting internet data";
  }

  List<MusicData> filterdata(title) {
    // ignore: deprecated_member_use
    List<MusicData> list = <MusicData>[];
    for (int i = 0; i < _list!.length; i++) {
      if (_list![i].album == title) {
        list.add(_list![i]);
      }
    }
    return list;
  }
}
