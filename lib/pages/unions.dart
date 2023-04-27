// import 'dart:js';

import 'dart:async';

//import 'dart:ffi';

// import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:Tirthankar/core/language.dart';
import 'package:Tirthankar/models/union.dart';
import 'package:Tirthankar/pages/unionlist.dart';
import 'package:Tirthankar/widgets/custom_buildDrawer.dart';

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

class UnionsPage extends StatefulWidget {
  String? appname;
  UnionsPage({this.appname});
  @override
  _UnionsPageState createState() => _UnionsPageState(appname);
}

class _UnionsPageState extends State<UnionsPage>
    with SingleTickerProviderStateMixin {
  String? appname;
  // Data data;
  _UnionsPageState(this.appname); // List<MusicModel> _list1;
  final sqllitedb dbHelper = new sqllitedb();
  final languageSelector selectlang = new languageSelector();
  final common_methods commonmethod = new common_methods();
  List<UnionData>? _list;
  List<UnionData>? _groups;
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
    downloadUnionList(appname!);
    // getFilePath();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // ignore: missing_return
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
          throw "Failed to navigate back to homepage";
        },
        child: Scaffold(
          appBar: commonmethod.buildAppBar(context, appname!),
          drawer: new Drawer(child: CustomeBuildDrawer()),
          backgroundColor: AppColors.mainColor,
          body: (_groups != null && _groups!.length > 0)
              ? ListView.builder(
                  itemCount: _groups!.length,
                  itemBuilder: (context, index) {
                    return buildCard(index);
                    // return ListTile(
                    //   title: Text('${items[index]}'),
                    // );
                  },
                )
              : Center(child: CircularProgressIndicator(strokeWidth: 5)),

          // Container(
          //   padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
          //   height: 100,
          //   width: double.maxFinite,
          //   color: AppColors.mainColor,
          //   child: buildCard("DIGAMBAR JAIN SAITWAL CENTRAL MEMBERS"),
          // ),
        ));
  }

  Card buildCard(index) {
    return Card(
      color: AppColors.white,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => UnionPage(
                appname: appname!,
                memberlist: filterlist(_groups![index].id),
              ),
            ),
          );
        },
        leading: SizedBox(
            height: 100,
            width: 100,
            child: Image.network(_groups![index].photourl)),
        // leading: Image.asset("assets/applogo_2.png"),
        title: Text(getLangText(index)),
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

  String getLangText(int s) {
    if (lang_selection == 0 || lang_selection == null) {
      return _groups![s].eName;
    } else {
      return _groups![s].mName;
    }
  }

  Future<List<UnionData>> downloadUnionList(String appname) async {
    // String url = "https://parshtech-songs-jainmusic.s3.us-east-2.amazonaws.com/input.json";
    String arrayObjsText = "";
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
        UNION_FILE,
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
      var groups = convert.jsonDecode(arrayObjsText)['groups'] as List;
      var tagObjsJson = convert.jsonDecode(arrayObjsText)['tags'] as List;
      this.setState(() {
        _groups = groups.map((tagJson) => UnionData.fromJson(tagJson)).toList();
        _list =
            tagObjsJson.map((tagJson) => UnionData.fromJson(tagJson)).toList();
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
    throw "Download Failed";
  }

  filterlist(int id) {
    List<UnionData> filterlist = [];
    UnionData userdata;
    // filterlist = _list;
    for (int i = 0; i < _list!.length; i++) {
      if (_list![i].linkid == id) {
        userdata = _list![i];
        filterlist.add(userdata);
      }
    }
    return filterlist;
  }
}
