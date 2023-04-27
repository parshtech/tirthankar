// import 'dart:js';

import 'dart:async';

//import 'dart:ffi';

// import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:Tirthankar/core/language.dart';
import 'package:Tirthankar/models/temple_model.dart';
import 'package:Tirthankar/models/union.dart';
import 'package:Tirthankar/widgets/custom_buildDrawer.dart';
import 'package:dio/adapter.dart';

import 'package:marquee_widget/marquee_widget.dart';
import 'package:Tirthankar/core/const.dart';
import 'package:Tirthankar/core/dbmanager.dart';
import 'package:Tirthankar/core/keys.dart';
// import 'package:ext_storage/ext_storage.dart';
import 'package:Tirthankar/widgets/common_methods.dart';
// import 'package:inuseAudioinfo.audioPlayer/inuseAudioinfo.audioPlayer.dart';
import 'package:flutter/material.dart';
import 'package:Tirthankar/pages/home.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as eos;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:toast/toast.dart';

class TemplePage extends StatefulWidget {
  String? appname;
  TemplePage({this.appname});
  @override
  _TemplePageState createState() => _TemplePageState(appname);
}

class Debouncer {
  final int? milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({this.milliseconds});
  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(microseconds: milliseconds!), action);
  }
}

class _TemplePageState extends State<TemplePage>
    with SingleTickerProviderStateMixin {
  String? appname;
  // Data data;
  _TemplePageState(this.appname); // List<MusicModel> _list1;
  final sqllitedb dbHelper = new sqllitedb();
  final languageSelector selectlang = new languageSelector();
  final common_methods commonmethod = new common_methods();
  List<TempleData>? _list;
  List<TempleData>? _mainlist;
  int? downloadId;
  // var tempDir;
  var dio = Dio();
  String downloadPerc = "0";
  bool isDownloading = false;
  bool fabsearch = false;
  final debouncer = Debouncer(milliseconds: 5000);

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
        throw "Failed to go back homepage";
      },
      child: Scaffold(
        appBar: commonmethod.buildAppBar(context, appname!),

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
        floatingActionButton: buildMusicFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        backgroundColor: AppColors.mainColor,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                if (fabsearch == true) buildTextSearch1(context),
                // addRunner ?
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      commonmethod.buildImageBox(
                          100.0, 100.0, 10.0, commonmethod.moduleImage(appname))
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

  Padding buildTextSearch1(context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Material(
        elevation: 5.0,
        color: AppColors.mainColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        child: TextField(
          style: TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black),
          autofocus: true,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            hintText: selectlang.getAlert(
                "Enter City/State name to search!!", lang_selection!),
          ),
          onChanged: (text) {
            // print(_mainlist.where((songrow) => (songrow.title
            //         .toLowerCase()
            //         .contains(text.toLowerCase()) ||
            //     songrow.hindiName.toLowerCase().contains(text.toLowerCase()))));
            debouncer.run(() {
              setState(() {
                // List<MusicData> templist;
                _list = _mainlist!
                    .where((songrow) => (songrow.eState
                            .toLowerCase()
                            .contains(text.toLowerCase()) ||
                        songrow.eAdd
                            .toLowerCase()
                            .contains(text.toLowerCase()) ||
                        songrow.eName
                            .toLowerCase()
                            .contains(text.toLowerCase()) ||
                        songrow.mState
                            .toLowerCase()
                            .contains(text.toLowerCase()) ||
                        songrow.mAdd
                            .toLowerCase()
                            .contains(text.toLowerCase()) ||
                        songrow.mName
                            .toLowerCase()
                            .contains(text.toLowerCase())))
                    .toList();
              });
            });
          },
          cursorColor: AppColors.mainColor,
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

  Padding buildMusicFAB() {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: FloatingActionButton(
        backgroundColor: Colors.orange,
        splashColor: Colors.amberAccent,
        child: Icon(Icons.search),
        onPressed: () {
          setState(() {
            if (fabsearch) {
              fabsearch = false;
              setState(() {
                _list = _mainlist;
              });
            } else {
              fabsearch = true;
            }
          });
        },
      ),
    );
  }

  Expanded buildListView() {
    return Expanded(
        //This is added so we can see overlay else this will be over button
        child: _list!.length > 0
            ? ListView.builder(
                physics:
                    BouncingScrollPhysics(), //This line removes the dark flash when you are at the begining or end of list menu. Just uncomment for
                // itemCount: _list.length,
                itemCount: _list == null ? 0 : _list!.length,
                padding: EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  TempleData memData = languageData(index);
                  return Container(
                      child: Card(
                          color: Colors.white,
                          // color:
                          //     (index % 2 == 0) ? Colors.blueGrey[50] : Colors.cyan[50],
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(
                                8), //This will all padding around all size
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .end, //This will allign button to left, else button will be infront of name

                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // ScrollingText(
                                      //   text: "This is my sample text",
                                      // ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        // child: Marquee(
                                        child: Text(
                                          " " + memData.eName,
                                          // getSongName(_list[index]),
                                          softWrap: true,
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // ),
                                      ),

                                      GestureDetector(
                                        onTap: () {
                                          debugPrint("Launching Map");
                                          commonmethod.launchMaps(
                                              memData.lat,
                                              memData.long,
                                              "Jain Temple " + memData.other1);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.home,
                                              color: AppColors.brown,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              // child: Marquee(

                                              child: Text(
                                                " " + memData.eAdd,
                                                // + "," + memData.eTaluka,
                                                // getSongName(_list[index]),
                                                softWrap: true,
                                                style: TextStyle(
                                                  color: AppColors.styleColor,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              // ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          commonmethod.phonePopup(
                                              context,
                                              commonmethod.filterMobile(
                                                  memData.mobile));
                                          // Navigator.push(context, MaterialPageRoute(builder: (context) => NewPageClassName()));
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              color: AppColors.brown,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              // child: Marquee(

                                              child: Text(
                                                memData.mobile,
                                                // + "," + memData.eTaluka,
                                                // getSongName(_list[index]),
                                                softWrap: true,
                                                style: TextStyle(
                                                  color: AppColors.styleColor,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              // ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Row(children: <Widget>[
                                        if (memData.rooms.toUpperCase() ==
                                            'YES')
                                          Icon(
                                            Icons.hotel,
                                            color: AppColors.brown,
                                          ),
                                        if (memData.pahad.toUpperCase() ==
                                            'YES')
                                          Icon(
                                            Icons.directions_walk,
                                            color: AppColors.brown,
                                          ),
                                        if (memData.food.toUpperCase() == 'YES')
                                          Icon(
                                            Icons.food_bank,
                                            color: AppColors.brown,
                                          ),
                                      ]),
                                    ],
                                  ),
                                  // new Spacer(),
                                ]),
                          )));

                  // child: buildCard(index),
                  // child: buildAnimatedContainer(index),
                },
              )
            : Center(
                child: Text(
                    selectlang.getAlert("No record found!!", lang_selection!)),
              ));
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

  TempleData languageData(index) {
    debugPrint("Row" + index.toString());
    String name,
        add,
        taluka,
        dist,
        state,
        pincode,
        rooms,
        pahad,
        food,
        email,
        mobile,
        other1,
        lat,
        long,
        photourl = "";
    // UnionData output = UnionData();

    // output.mobile = _list[index].mobile;
    if (lang_selection == 0 || lang_selection == null) {
      name = _list![index].eName;
      add = _list![index].eAdd +
          "," +
          _list![index].eTaluka +
          "," +
          _list![index].eDist +
          "," +
          _list![index].eState +
          " " +
          _list![index].pincode;
      taluka = _list![index].eTaluka;
      dist = _list![index].eDist;
      state = _list![index].eState;
      other1 = add;
      // return output;
    } else {
      name = _list![index].mName;
      add = _list![index].mAdd +
          "," +
          _list![index].mTaluka +
          "," +
          _list![index].mDist +
          "," +
          _list![index].mState +
          " " +
          _list![index].pincode;
      taluka = _list![index].mTaluka;
      dist = _list![index].mDist;
      state = _list![index].mState;
      other1 = _list![index].eAdd +
          "," +
          _list![index].eTaluka +
          "," +
          _list![index].eDist +
          "," +
          _list![index].eState +
          " " +
          _list![index].pincode;
      // return output;
    }
    pincode = _list![index].pincode;
    rooms = _list![index].rooms;
    pahad = _list![index].pahad;
    food = _list![index].food;
    email = _list![index].email;
    mobile = _list![index].mobile;
    lat = _list![index].lat;
    long = _list![index].long;
    return TempleData(
        0,
        taluka,
        "",
        add,
        email,
        "",
        "",
        other1,
        "",
        name,
        mobile,
        photourl,
        state,
        "",
        dist,
        "",
        pincode,
        rooms,
        pahad,
        food,
        lat,
        long);
  }

  AnimatedContainer buildAnimatedContainer(int index) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        //This below code will change the color of selected area or song being played.
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        //End of row color change
        child: Padding(
          padding:
              const EdgeInsets.all(8), //This will all padding around all size
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
                          _list![index].eName,
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
                      selectlang.getAlert(_list![index].eName, lang_selection!),
                      style: TextStyle(
                        color: AppColors.styleColor.withAlpha(90),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                new Spacer(),
                // IconButton(
                //     alignment: Alignment.centerLeft,
                //     icon: Icon(
                //       Icons.book_outlined,
                //       color: AppColors.brown200,
                //     ),
                //     // alignment: Alignment.centerRight,
                //     onPressed: () {
                //       // Navigator.of(context).push(
                //       //   MaterialPageRoute(
                //       //     builder: (_) => Pdfview(
                //       //       appname: appname,
                //       //       pdfpage: _list[index].pdfpage,
                //       //       filepath: homefolder.path + "/" + _list[index].pdffile,
                //       //     ),
                //       //   ),
                //       // );
                //     })
              ]),
        ));
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
        TEMPLE_FILE,
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
            tagObjsJson.map((tagJson) => TempleData.fromJson(tagJson)).toList();
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
    setState(() {
      _mainlist = _list;
      // uiloading();
    });
    throw "Failed to download list";
  }
}
