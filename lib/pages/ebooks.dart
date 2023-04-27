// import 'dart:js';

import 'dart:async';

//import 'dart:ffi';

// import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io' as io;
import 'dart:io';
import 'package:Tirthankar/core/language.dart';
import 'package:Tirthankar/widgets/custom_buildDrawer.dart';
import 'package:dio/adapter.dart';

// import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:Tirthankar/core/const.dart';
import 'package:Tirthankar/core/dbmanager.dart';
import 'package:Tirthankar/core/keys.dart';
// import 'package:ext_storage/ext_storage.dart';
import 'package:Tirthankar/models/music.dart';
import 'package:Tirthankar/pages/pdf.dart';
import 'package:Tirthankar/widgets/common_methods.dart';
// import 'package:inuseAudioinfo.audioPlayer/inuseAudioinfo.audioPlayer.dart';
import 'package:flutter/material.dart';
import 'package:Tirthankar/pages/home.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as eos;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';

class EbookPage extends StatefulWidget {
  String? appname;
  List<MusicData>? list;
  String? imageurl;
  EbookPage({this.appname, this.list, this.imageurl});
  @override
  _EbookPageState createState() => _EbookPageState(appname!, list!, imageurl!);
}

class _EbookPageState extends State<EbookPage>
    with SingleTickerProviderStateMixin {
  String appname;
  List<MusicData> list;
  String imageurl;
  // Data data;
  _EbookPageState(
      this.appname, this.list, this.imageurl); // List<MusicModel> _list1;
  final sqllitedb dbHelper = new sqllitedb();
  final languageSelector selectlang = new languageSelector();
  final common_methods commonmethod = new common_methods();
  List<MusicData>? _list;
  int? downloadId;
  // var tempDir;
  var dio = Dio();
  String downloadPerc = "0";
  bool isDownloading = false;

  // AudioPlayerState playerState;
  @override
  void initState() {
    currentappname = "BOOKS";
    // data = inuseAudioinfo;
    _list = list;
    if (_list == null) {
      downloadSongList(appname);
    }
    // downloadSongList(appname);
    // getFilePath();

    super.initState();
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
        backgroundColor: AppColors.mainColor,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                // addRunner ?
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      commonmethod.buildImageBox(100.0, 100.0, 10.0, imageurl)
                    ],
                  ),
                ),
                (_list == null || _list!.length == 0)
                    ? CircularProgressIndicator()
                    : buildListView(),
              ],
            ),
          ],
        ),
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

  Future download2(Dio dio, String url, String savePath) async {
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(response.headers);
      io.File file = io.File(savePath);
      var raf = file.openSync(mode: io.FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();

      setState(() {
        downloadPerc = '0';
        isDownloading = false;
        downloadId = null;
      });
    } catch (e) {
      setState(() {
        downloadPerc = '0';
        isDownloading = false;
        downloadId = null;
      });
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      downloadPerc = (received / total * 100).toStringAsFixed(0) + "%";
      // print((received / total * 100).toStringAsFixed(0) + "%");
      print(downloadPerc);
    }
  }

  Expanded buildListView() {
    return Expanded(
      //This is added so we can see overlay else this will be over button
      child: ListView.builder(
        physics:
            BouncingScrollPhysics(), //This line removes the dark flash when you are at the begining or end of list menu. Just uncomment for
        // itemCount: _list.length,
        itemCount: _list == null ? 0 : _list!.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, index) {
          if (inuseAudioinfo != null) {
            if (inuseAudioinfo!.songId != null &&
                inuseAudioinfo!.appname == appname) {
              child:
              buildAnimatedContainer(inuseAudioinfo!.songId);
            }
          }
          return GestureDetector(
            onTap: () {
              booklist = _list;
              if (kIsWeb)
                commonmethod.launchURL(_list![index].songURL);
              else if (io.File(homefolder.path + "/" + _list![index].pdffile)
                      .existsSync() ==
                  true)
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Pdfview(
                      appname: appname,
                      pdfpage: _list![index].pdfpage,
                      filepath: homefolder.path + "/" + _list![index].pdffile,
                    ),
                  ),
                );
              else
                Toast.show(
                    selectlang.getAlert(
                        "Download Book to view", lang_selection!),
                    duration: 1,
                    gravity: 0);
            },
            child: buildAnimatedContainer(index),
          );
        },
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

  AnimatedContainer buildAnimatedContainer(int? index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      //This below code will change the color of selected area or song being played.
      decoration: BoxDecoration(
        color: inuseAudioinfo != null
            ? _list![index!].id == inuseAudioinfo!.playId &&
                    inuseAudioinfo!.appname == appname
                ? AppColors.activeColor
                : AppColors.mainColor
            : AppColors.mainColor,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      //End of row color change
      child: Padding(
        padding:
            const EdgeInsets.all(7), //This will all padding around all size
        child: Row(
          mainAxisAlignment: MainAxisAlignment
              .end, //This will allign button to left, else button will be infront of name

          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // ScrollingText(
                //   text: "This is my sample text",
                // ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Marquee(
                    child: Text(
                      (lang_selection == 0 || lang_selection == null)
                          ? _list![index!].title
                          : _list![index!].hindiName,
                      // getSongName(_list[index]),
                      softWrap: true,
                      style: TextStyle(
                        color: AppColors.styleColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Text(
                  (lang_selection == 0 || lang_selection == null)
                      ? _list![index].album
                      : _list![index].mname,
                  // selectlang.getAlert(_list[index].album, lang_selection),
                  style: TextStyle(
                    color: AppColors.styleColor.withAlpha(90),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            new Spacer(),

            if (!kIsWeb &&
                io.File(homefolder.path + "/" + _list![index].pdffile)
                        .existsSync() ==
                    true)
              IconButton(
                  alignment: Alignment.centerLeft,
                  icon: Icon(
                    Icons.book_outlined,
                    color: AppColors.brown200,
                  ),
                  // alignment: Alignment.centerRight,
                  onPressed: () {
                    booklist = _list;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Pdfview(
                          appname: appname,
                          pdfpage: _list![index].pdfpage,
                          filepath:
                              homefolder.path + "/" + _list![index].pdffile,
                        ),
                      ),
                    );
                  })
            else if (isDownloading && downloadId == index)
              CircularProgressIndicator(
                  // value: double.parse(downloadPerc.replaceAll("%", "")),
                  ) // new Spacer(),
            else
              IconButton(
                  alignment: Alignment.centerLeft,
                  icon: Icon(
                    Icons.cloud_download,
                    color: AppColors.brown200,
                  ),
                  // alignment: Alignment.centerRight,
                  onPressed: () {
                    downloadId = index;
                    if (kIsWeb)
                      commonmethod.launchURL(_list![index].songURL);
                    else
                      setState(() {
                        isDownloading = true;
                      });

                    downloadFile(_list![index].pdffile, _list![index].songURL);
                  })
            // : new CircularProgressIndicator() // new Spacer(),
          ],
        ),
      ),
    );
  }

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
      var tagObjsJson = convert.jsonDecode(arrayObjsText)['tags'] as List;
      this.setState(() {
        _list =
            tagObjsJson.map((tagJson) => MusicData.fromJson(tagJson)).toList();
        if (_list!.length > 0) {
          print(_list!.length);
          if (appname == "VIDHAN" || appname == "JAIN POOJA") {
            filterdata();
          }
        } else {
          Toast.show(
              selectlang.getAlert("Check internet connection", lang_selection!),
              duration: 1,
              gravity: 0);
          // commonmethod.displayDialog(
          //   context,
          //   "",
          //   selectlang.getAlert("Check internet connection", lang_selection),
          //   Icon(
          //     Icons.signal_wifi_off,
          //     size: 100,
          //     color: AppColors.red200,
          //   ),
          // );
        }
      });
    }
    throw "Failed to download Books";
  }

  String getSongName(MusicData list, String field) {
    if (lang_selection == 1) {
      if (field == "TITLE") {
        return list.hindiName;
      } else {
        return list.hindiName;
      }
    } else {
      return list.title;
    }
  }

  Future<void> downloadFile(String filename, String fileurl) async {
    // var tempDir;
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    // await getTemporaryDirectory();
    String fullPath = homefolder.path + "/" + filename;
    print('full path $fullPath');
    if (await Permission.storage.request().isGranted) {
      download2(dio, fileurl, fullPath);
    } else {
      Toast.show(
          selectlang.getAlert("Storage Permission Required", lang_selection!),
          duration: 1,
          gravity: 0);
      // commonmethod.displayDialog(
      //   context,
      //   "Storage",
      //   selectlang.getAlert("Storage Permission Required", lang_selection),
      //   Icon(
      //     Icons.storage,
      //     size: 100,
      //     color: AppColors.red200,
      //   ),
      // );
    }
  }

  filterdata() {
    List<MusicData> list = <MusicData>[];
    for (int i = 0; i < _list!.length; i++) {
      if (_list![i].album == appname) {
        list.add(_list![i]);
      }
    }
    _list = list;
  }

  String? getAlbum(langIndex) {
    if (langIndex == 0 || langIndex == null) {
      // return module;
    } else {}
  }
  // Future<void> getFilePath() async {
  //   var dir;
  //   if (io.Platform.isAndroid) {
  //     dir = await getExternalStorageDirectory();
  //     // tempDir = "/sdcard/download/";
  //   } else if (io.Platform.isIOS) {
  //     dir = getApplicationDocumentsDirectory();
  //   }
  //   setState(() {
  //     tempDir = dir;
  //   });
  // }
}
