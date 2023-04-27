// import 'dart:js';

import 'dart:async';

//import 'dart:ffi';

// import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:Tirthankar/core/language.dart';
import 'package:Tirthankar/widgets/custom_buildDrawer.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dio/adapter.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' as io;
import 'package:marquee_widget/marquee_widget.dart';
import 'package:Tirthankar/core/const.dart';
import 'package:Tirthankar/core/dbmanager.dart';
import 'package:Tirthankar/core/keys.dart';
import 'package:Tirthankar/models/listdata.dart';
import 'package:Tirthankar/models/music.dart';
import 'package:Tirthankar/pages/pdf.dart';
import 'package:Tirthankar/widgets/common_methods.dart';
// import 'package:inuseAudioinfo.audioPlayer/inuseAudioinfo.audioPlayer.dart';
import 'package:flutter/material.dart';
import 'package:Tirthankar/pages/home.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as eos;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ListPage extends StatefulWidget {
  String? appname;
  ListPage({this.appname});
  @override
  _ListPageState createState() => _ListPageState(appname!);
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

class _ListPageState extends State<ListPage>
    with SingleTickerProviderStateMixin {
  String appname;
  final debouncer = Debouncer(milliseconds: 5000);
  // Data data;
  _ListPageState(this.appname); // List<MusicModel> _list1;
  final sqllitedb dbHelper = new sqllitedb();
  final languageSelector selectlang = new languageSelector();
  final common_methods commonmethod = new common_methods();
  List<MusicData>? _list;
  List<MusicData>? _mainlist;

  int? _playId;
  int? _songId;
  int? _favstate;
  bool? addRunner = true;
  bool? listbuilder = false;
  bool? fabsearch = false;
  AssetsAudioPlayer? get _assetsAudioPlayer =>
      AssetsAudioPlayer.withId("music");
  final List<StreamSubscription>? _subscriptions = [];
  // AudioPlayerState playerState;
  var countdown;
  @override
  void initState() {
    // data = inuseAudioinfo;
    currentappname = "HOME";

    if (inuseAudioinfo == null || inuseAudioinfo!.list == null) {
      inuseAudioinfo = new Data();
      inuseAudioinfo!.audioPlayer = AssetsAudioPlayer();
      inuseAudioinfo!.isPause = false;
      inuseAudioinfo!.isRepeat = false;
      inuseAudioinfo!.isShuffle = false;
      inuseAudioinfo!.isPlaying = false;
      inuseAudioinfo!.appname = appname;
      _playId = 0;
      if (kIsWeb) {
        listbuilder = true;
        downloadSongList(appname);
      } else {
        listbuilder = true;
        this.downloadSongListDB(appname);
      }
    } else if (appname == inuseAudioinfo!.appname) {
      _list = inuseAudioinfo!.list;
      _mainlist = _list;
      _playId = inuseAudioinfo!.playId;
      _songId = inuseAudioinfo!.songId;
    } else {
      if (kIsWeb) {
        listbuilder = true;
        downloadSongList(appname);
      } else {
        listbuilder = true;
        this.downloadSongListDB(appname);
      }
      _playId = inuseAudioinfo!.playId;
      _songId = inuseAudioinfo!.songId;
    }
    audioListner();
    super.initState();
  }

  // stream() {
  //   _positionSubscription =
  //       inuseAudioinfo.audioPlayer.currentPosition.listen((p) {
  //     setState(() {
  //       inuseAudioinfo.position = p;
  //       print("I am At 5 sec");
  //     });
  //   });
  // }

  audioListner() {
    _subscriptions!
        .add(inuseAudioinfo!.audioPlayer!.playlistAudioFinished.listen((data) {
      print("playlistAudioFinished : $data");
      if (inuseAudioinfo!.isPlaying!) {
        inuseAudioinfo!.audioPlayer!.stop();
        playnextSong();
        // mySong();
      }
    }));
    _subscriptions!
        .add(inuseAudioinfo!.audioPlayer!.audioSessionId.listen((sessionId) {
      print("audioSessionId : $sessionId");
    }));
    //_subscriptions.add(_assetsAudioPlayer.current.listen((data) {
    //  print("current : $data");
    //}));
    //_subscriptions.add(_assetsAudioPlayer.onReadyToPlay.listen((audio) {
    //  print("onReadyToPlay : $audio");
    //}));
    //_subscriptions.add(_assetsAudioPlayer.isBuffering.listen((isBuffering) {
    //  print("isBuffering : $isBuffering");
    //}));
    //_subscriptions.add(_assetsAudioPlayer.playerState.listen((playerState) {
    //  print("playerState : $playerState");
    //}));
    //_subscriptions.add(_assetsAudioPlayer.isPlaying.listen((isplaying) {
    //  print("isplaying : $isplaying");
    //}));
    _subscriptions!
        .add(AssetsAudioPlayer.addNotificationOpenAction((notification) {
      print("Inside audio notification");
      return false;
    }));
    inuseAudioinfo!.audioPlayer!.currentPosition.listen((event) {
      setState(() {
        if (inuseAudioinfo!.audioPlayer!.current.hasValue) {
          if (inuseAudioinfo!.audioPlayer!.current.value != null) {
            inuseAudioinfo!.position =
                inuseAudioinfo!.audioPlayer!.current.value!.audio.duration;
            inuseAudioinfo!.duration = event;
            // print("Position Value from event Duration=" +
            //     inuseAudioinfo.duration.inSeconds.toString() +
            //     " Position=" +
            //     inuseAudioinfo.position.inSeconds.toString());
          }
        }
      });
    });
    // inuseAudioinfo.audioPlayer.playlistAudioFinished.listen((Playing playing) {
    //   if (inuseAudioinfo.isPlaying) {
    //     inuseAudioinfo.audioPlayer.stop();
    //     playnextSong();
    //     // mySong();
    //   } else {
    //     playnextSong();
    //   }
    // });
  }

  playnextSong() {
    // mySong() {
    inuseAudioinfo!.position = new Duration();
    print("Song Duration" + (inuseAudioinfo!.duration!.inSeconds).toString());
    print("Song Position" + (inuseAudioinfo!.position!.inSeconds).toString());
    inuseAudioinfo!.isPlaying = false;
    if (inuseAudioinfo!.isRepeat!) {
      // inuseAudioinfo.songId = _songId;
    } else {
      if (inuseAudioinfo!.isShuffle!) {
        var element =
            inuseAudioinfo!.list![random.nextInt(inuseAudioinfo!.list!.length)];
        inuseAudioinfo!.songId = element.id;
      } else {
        if (inuseAudioinfo!.songId! < inuseAudioinfo!.list!.length - 1) {
          inuseAudioinfo!.songId = (inuseAudioinfo!.songId! + 1);
        } else if (inuseAudioinfo!.songId == inuseAudioinfo!.list!.length - 1) {
          inuseAudioinfo!.songId = 0;
        } else {
          inuseAudioinfo!.songId = inuseAudioinfo!.songId;
        }
      }
    }
    _player(inuseAudioinfo!.songId!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        onbackPress();
        // inuseAudioinfo = buildData();
        throw "Failed to load previous page onbackpress";
      },
      child: Scaffold(
        appBar: commonmethod.buildAppBar(context, appname),
        drawer: new Drawer(child: CustomeBuildDrawer()),
        floatingActionButton: buildMusicFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        backgroundColor: AppColors.mainColor,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                // addRunner ?
                if (fabsearch == true) buildTextSearch1(context),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      commonmethod.buildImageBox(100.0, 100.0, 10.0,
                          commonmethod.moduleImage(appname)),
                      // Text("      "),
                      // IconButton(
                      //     icon: Icon(
                      //       Icons.star_half,
                      //       color: AppColors.styleColor,
                      //       size: 50,
                      //     ),
                      //     onPressed: () {})
                    ],
                  ),
                ),
                if (_list == null)
                  CircularProgressIndicator()
                else
                  buildListView(),
                if (_list != null) buildMusicBar(context),

                // buildPlayerMenu1(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildList() {}

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
                "Enter Song/Bhajan name to search!!", lang_selection!),
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
                    .where((songrow) => (songrow.title
                            .toLowerCase()
                            .contains(text.toLowerCase()) ||
                        songrow.hindiName
                            .toLowerCase()
                            .contains(text.toLowerCase())))
                    .toList();
                // if (templist.length > 0) {
                //   _list = templist;
                // } else {
                //   print("No Matching record found!!");
                // }
              });
            });
            // appBloc.addToLocation.add(text);
          },
          // style: dropDownMenuItemStyle,
          cursorColor: AppColors.mainColor,
          // decoration: InputDecoration(
          //   contentPadding:
          //       EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
          //   suffixIcon: Material(
          //     elevation: 2.0,
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(30.0),
          //     ),
          //     child: InkWell(
          //       onTap: () {},
          //       child: Icon(
          //         Icons.search,
          //         color: Colors.black,
          //       ),
          //     ),
          //   ),
          //   border: InputBorder.none,
          // ),
        ),
      ),
    );
  }

  Padding buidTextSearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 30,
        decoration: BoxDecoration(
            color: AppColors.lightBlue,
            // borderRadius: BorderRadius.all(
            //   Radius.circular(16),
            // ),
            shape: BoxShape.rectangle,
            border: Border(
              top: BorderSide(color: AppColors.white),
            ),
            gradient: LinearGradient(
                colors: <Color>[AppColors.white, Colors.blue[50]!])),
        child: TextField(
            style: TextStyle(fontSize: 40.0, height: 2.0, color: Colors.black)),
      ),
    );
  }

  Container buildMusicBar(BuildContext context) {
    return Container(
        height: 125,
        decoration: BoxDecoration(
            // color: AppColors.activeColor,
            border: Border(
              top: BorderSide(color: AppColors.white),
            ),
            gradient: LinearGradient(
                colors: <Color>[Colors.deepOrange, Colors.orangeAccent])),
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
                  child: Align(
                      alignment: Alignment.bottomLeft,
                      child: commonmethod.buildImageBox(
                          70.0,
                          70.0,
                          5,
                          commonmethod.moduleImage(inuseAudioinfo != null
                              ? inuseAudioinfo!.appname
                              : appname))),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                        (inuseAudioinfo == null ||
                                inuseAudioinfo!.title == null)
                            ? "00.00"
                            : _printDuration(inuseAudioinfo!.duration!),
                        // softWrap: true,
                        style: TextStyle(
                          // color: AppColors.black.withAlpha(90),
                          color: AppColors.black.withAlpha(150),
                          fontSize: 14,
                        )),
                    slider(),
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.5,
                    //   // child: Expanded(child: slider()),
                    //   // child: kIsWeb ? null : slider(),
                    //   child: slider(),
                    // ),
                    Text(
                        (inuseAudioinfo == null ||
                                inuseAudioinfo!.title == null)
                            ? "00.00"
                            : _printDuration(inuseAudioinfo!.position!),
                        // softWrap: true,
                        style: TextStyle(
                          // color: AppColors.black.withAlpha(90),
                          color: AppColors.black.withAlpha(150),
                          fontSize: 14,
                        )),
                  ],
                ),
                // Center(
                //   child: Container(
                //     decoration: BoxDecoration(
                //         border: Border(
                //       top: BorderSide(color: Colors.red[300]),
                //       // bottom: BorderSide(color: AppColors.white)
                //     )),

                //     child: Wrap(
                //       alignment: WrapAlignment.center,
                //       // spacing: kIsWeb
                //       //     ? MediaQuery.of(context).size.width * 0.1
                //       //     : 1, // space between two icons
                //       children: <Widget>[
                //         Text(
                //             (inuseAudioinfo == null ||
                //                     inuseAudioinfo.title == null)
                //                 ? "00.00"
                //                 : _printDuration(inuseAudioinfo.duration),
                //             // softWrap: true,
                //             style: TextStyle(
                //               // color: AppColors.black.withAlpha(90),
                //               color: AppColors.black.withAlpha(150),
                //               fontSize: 14,
                //             )),
                //         slider(),
                //         // Container(
                //         //   width: MediaQuery.of(context).size.width * 0.5,
                //         //   // child: Expanded(child: slider()),
                //         //   // child: kIsWeb ? null : slider(),
                //         //   child: slider(),
                //         // ),
                //         Text(
                //             (inuseAudioinfo == null ||
                //                     inuseAudioinfo.title == null)
                //                 ? "00.00"
                //                 : _printDuration(inuseAudioinfo.position),
                //             // softWrap: true,
                //             style: TextStyle(
                //               // color: AppColors.black.withAlpha(90),
                //               color: AppColors.black.withAlpha(150),
                //               fontSize: 14,
                //             )),
                //       ],
                //     ),
                //   ),
                // ),
                // Container(
                //   width: MediaQuery.of(context).size.width * 0.7,
                //   // child: Expanded(child: slider()),
                //   // child: kIsWeb ? null : slider(),
                //   child: slider(),
                // ),
                // Container(child: inuseAudioinfo.audioPlayer
                //     .builderCurrentPosition(builder: (context, duration) {
                //   print(duration.toString());

                //   // setState(() {
                //   inuseAudioinfo.duration = duration;
                //   // });
                //   return Spacer();
                // })),
                Center(
                  child: Marquee(
                    child: Text(
                        ((inuseAudioinfo == null ||
                                    inuseAudioinfo!.title == null)
                                ? selectlang.getAlbum(appname, lang_selection!)
                                : inuseAudioinfo!.title)! +
                            "",
                        softWrap: true,
                        style: TextStyle(
                          // color: AppColors.black.withAlpha(90),
                          color: AppColors.black.withAlpha(150),
                          fontSize: 16,
                        )),
                  ),
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(color: Colors.red[300]!),
                      // bottom: BorderSide(color: AppColors.white)
                    )),
                    child: Wrap(
                      spacing: kIsWeb
                          ? MediaQuery.of(context).size.width * 0.1
                          : 25, // space between two icons
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                              inuseAudioinfo != null
                                  ? inuseAudioinfo!.isRepeat!
                                      ? Icons.repeat_one
                                      : Icons.repeat
                                  : Icons.repeat,
                              color: inuseAudioinfo != null
                                  ? inuseAudioinfo!.isRepeat!
                                      ? AppColors.brown
                                      : AppColors.darkBrown
                                  : AppColors.darkBrown),
                          onPressed: () {
                            print("User clicked Repeat one.");
                            if (inuseAudioinfo!.playId != null) {
                              if (inuseAudioinfo!.isRepeat!) {
                                setState(() {
                                  inuseAudioinfo!.isRepeat = false;
                                });
                              } else {
                                setState(() {
                                  inuseAudioinfo!.isRepeat = true;
                                });
                              }
                            } else {
                              selectMusicNotification();
                            }
                          },
                        ),
                        IconButton(
                            icon: Icon(
                              inuseAudioinfo != null
                                  ? inuseAudioinfo!.isPlaying!
                                      ? Icons.pause
                                      : Icons.play_arrow
                                  : Icons.play_arrow,
                              color: AppColors.darkBrown,
                            ),
                            onPressed: () {
                              _player(_songId!);
                            }),
                        IconButton(
                            icon: Icon(
                              Icons.stop,
                              color: AppColors.darkBrown,
                            ),
                            onPressed: () {
                              if (inuseAudioinfo!.isPlaying!) {
                                // _inuseAudioinfo.audioPlayer.stop();
                                stop();
                              }

                              // isPlaying = false;
                            }),
                        IconButton(
                            icon: Icon(
                              Icons.shuffle,
                              color: inuseAudioinfo != null
                                  ? inuseAudioinfo!.isShuffle!
                                      ? AppColors.brown
                                      : AppColors.darkBrown
                                  : AppColors.darkBrown,
                            ),
                            onPressed: () {
                              if (inuseAudioinfo!.isShuffle!) {
                                setState(() {
                                  inuseAudioinfo!.isShuffle = false;
                                });
                              } else {
                                setState(() {
                                  inuseAudioinfo!.isShuffle = true;
                                });
                              }
                            }),
                      ],
                    ),
                  ),
                ),
                // ),
                // ),
              ],
            )
          ],
        ));
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

  Expanded buildAddView() {
    return Expanded(
        child: Marquee(
            child: Container(
                width: MediaQuery.of(context).size.width * 1.0,
                // height: 100,
                child: Image.asset(
                  "assets/google.png",
                  fit: BoxFit.fitWidth,
                ))));
  }

  Expanded buildListView() {
    return Expanded(
        //This is added so we can see overlay else this will be over button
        child: _list!.length > 0
            ? ListView.builder(
                physics:
                    BouncingScrollPhysics(), //This line removes the dark flash when you are at the begining or end of list menu. Just uncomment for
                // itemCount: _list.length,
                itemCount: _list!.length,
                padding: EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  _favstate = _list![index].isfave;
                  if (inuseAudioinfo != null) {
                    if (inuseAudioinfo!.songId != null &&
                        inuseAudioinfo!.appname == appname) {
                      if (_list![index].id == inuseAudioinfo!.songId) {
                        child:
                        buildAnimatedContainer(inuseAudioinfo!.songId!);
                      } else {
                        child:
                        buildAnimatedContainer(index);
                      }
                      // child:
                      // buildAnimatedContainer(inuseAudioinfo.songId);
                    }
                  }
                  return GestureDetector(
                    onTap: () {
                      if (inuseAudioinfo!.appname != appname) {
                        inuseAudioinfo!.list = _list;
                        inuseAudioinfo!.songId = index;
                        inuseAudioinfo!.appname = appname;
                      } else {
                        inuseAudioinfo!.songId = index;
                      }

                      _songId = index;
                      if (_list![index].songURL == null ||
                          _list![index].songURL == "" ||
                          (_list![index].songURL).isEmpty) {
                        if (_list![index].songURL != "") {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => Pdfview(
                                appname: appname,
                                pdfpage: _list![index].pdfpage,
                              ),
                            ),
                          );
                        } else {
                          Toast.show(
                              selectlang.getAlert("Unable to play this song!!",
                                  lang_selection!),
                              duration: 1,
                              gravity: 0);
                          // commonmethod.displayDialog(
                          //   context,
                          //   "",
                          //   selectlang.getAlert(
                          //       "Unable to play this song!!", lang_selection),
                          //   Icon(
                          //     Icons.library_music,
                          //     size: 100,
                          //     color: AppColors.white54,
                          //   ),
                          // );
                        }
                      } else {
                        _player(index);
                      }
                    },
                    child: buildAnimatedContainer(index),
                  );
                },
              )
            : Center(
                child: Text(selectlang.getAlert(
                    "No Song/Bhajan found!!", lang_selection!)),
              ));
  }

  void onbackPress() {
    if (inuseAudioinfo!.isPlaying == true || inuseAudioinfo!.isPause == true) {
      if (inuseAudioinfo == null) {
        inuseAudioinfo = buildData();
      }
    } else {
      inuseAudioinfo = null;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => HomePage(
          appname: appname,
          // data: ndata,
        ),
      ),
    );
  }

  Data buildData() {
    String app;
    List<MusicData> data;
    if (inuseAudioinfo!.appname != appname) {
      app = inuseAudioinfo!.appname!;
      data = inuseAudioinfo!.list!;
    } else {
      app = appname;
      data = _list!;
    }
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
        albumImage: commonmethod.moduleImage(appname),
        list: data,
        appname: app);
  }

  AnimatedContainer buildAnimatedContainer(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      //This below code will change the color of selected area or song being played.
      decoration: BoxDecoration(
        color: inuseAudioinfo != null
            ? _list![index].id == inuseAudioinfo!.playId &&
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
                      getSongName(_list![index]),
                      softWrap: true,
                      style: TextStyle(
                        color: AppColors.styleColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Text(
                  selectlang.getAlbum(_list![index].album, lang_selection!),
                  style: TextStyle(
                    color: AppColors.styleColor.withAlpha(90),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            new Spacer(),

            if (!kIsWeb &&
                (io.File(homefolder.path + "/" + _list![index].pdffile)
                        .existsSync() ==
                    true))
              IconButton(
                  alignment: Alignment.centerLeft,
                  icon: Icon(
                    Icons.book,
                    color: AppColors.brown200,
                  ),
                  color: AppColors.red200,
                  // alignment: Alignment.centerRight,
                  onPressed: () {
                    if (_list![index].pdffile != null ||
                        _list![index].pdffile != "") {
                      buildData();
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
                      setState(() {});
                    }
                  }), // new Spacer(),
            if (!kIsWeb)
              IconButton(
                  icon: Icon(_favstate == 1 ? Icons.star : Icons.star_border),
                  color: AppColors.red200,
                  onPressed: () {
                    setState(() {
                      if (_list![index].isfave == 1) {
                        _favstate = 0;
                        _list![index].isfave = 0;
                        dbHelper.updateFavorite(_list![index].id, 0);
                        commonmethod.displayDialog(
                          context,
                          "",
                          "Song removed from favorite",
                          Icon(
                            Icons.star_border,
                            size: 100,
                            color: AppColors.red200,
                          ),
                        );
                      } else {
                        _favstate = 1;
                        _list![index].isfave = 1;
                        dbHelper.updateFavorite(_list![index].id, 1);
                        commonmethod.displayDialog(
                          context,
                          "",
                          "Song added to favorite",
                          Icon(
                            Icons.star,
                            size: 100,
                            color: AppColors.red200,
                          ),
                        );
                      }
                    });
                  }),
            if (appname == 'Chalisa')
              IconButton(
                  icon: Icon(
                    inuseAudioinfo!.isPlaying! &&
                            _list![index].id == _playId &&
                            index == _songId &&
                            inuseAudioinfo!.appname == appname
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: AppColors.styleColor,
                  ),
                  onPressed: () {
                    if (_songId == null) {
                      _player(index);
                    } else if (index == _songId) {
                      _player(_songId!);
                    } else {
                      _player(index);
                    }
                  })
          ],
        ),
      ),
    );
  }

  Widget slider1() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.red[700],
        inactiveTrackColor: Colors.red[200],
        trackShape: RoundedRectSliderTrackShape(),
        trackHeight: 2.0,
        thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: 7.0, disabledThumbRadius: 7.0),
        thumbColor: Colors.redAccent,
        disabledThumbColor: Colors.red[200],
        overlayColor: Colors.red.withAlpha(32),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 18.0),
        tickMarkShape: RoundSliderTickMarkShape(),
        activeTickMarkColor: Colors.red[700],
        inactiveTickMarkColor: Colors.red[100],
        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
        valueIndicatorColor: Colors.redAccent,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      child: Slider(
          // activeColor: Colors.red.withAlpha(64),
          // inactiveColor: Colors.red[200],
          label: (getTimeString(
              (inuseAudioinfo == null || inuseAudioinfo!.duration == null)
                  ? 0
                  : inuseAudioinfo!.duration!.inSeconds)),
          min: 0.0,
          divisions: 10,
          max: ((inuseAudioinfo == null || inuseAudioinfo!.position == null)
                  ? 0
                  : inuseAudioinfo!.position!.inSeconds)
              .toDouble(),
          value: (getSleepkerPosition(
                  (inuseAudioinfo == null || inuseAudioinfo!.position == null)
                      ? 0
                      : inuseAudioinfo!.position!.inSeconds,
                  (inuseAudioinfo == null || inuseAudioinfo!.duration == null)
                      ? 0
                      : inuseAudioinfo!.duration!.inSeconds))
              .toDouble(),
          onChangeStart: (double value) {
            print('Start value is ' + value.toString());
          },
          onChangeEnd: (double value) {
            print('Finish value is ' + value.toString());
          },
          onChanged: (double value) {
            setState(() {
              if (value == inuseAudioinfo!.position!.inSeconds) {
              } else {
                seekToSecond(value.toInt());
                value = value;
              }
            });
          }),
    );
  }

  String getTimeString(int value) {
    var d = Duration(seconds: value);
    List<String> parts = d.toString().split(':');
    String h = parts[0].padLeft(2, '0');
    String m = parts[1].padLeft(2, '0');
    String s = (parts[2].substring(0, 2)).padLeft(2, '0');
    return '$h:$m:$s';
  }

  Widget slider2() {
    return
        // AwesomeSlider(
        //   min: 0.0,
        //   max: ((inuseAudioinfo == null || inuseAudioinfo.position == null)
        //           ? 0
        //           : inuseAudioinfo.position.inSeconds)
        //       .toDouble(),
        //   value: (getSleepkerPosition(
        //           (inuseAudioinfo == null || inuseAudioinfo.position == null)
        //               ? 0
        //               : inuseAudioinfo.position.inSeconds,
        //           (inuseAudioinfo == null || inuseAudioinfo.duration == null)
        //               ? 0
        //               : inuseAudioinfo.duration.inSeconds))
        //       .toDouble(),
        //   thumbColor: Color(0xFF100887),
        //   roundedRectangleThumbRadius: 25.0,
        //   thumbSize: 100.0,
        //   topLeftShadow: true,
        //   topLeftShadowColor: Colors.lightBlueAccent,
        //   topLeftShadowBlur: MaskFilter.blur(BlurStyle.normal, 11.0),
        //   bottomRightShadow: true,
        //   bottomRightShadowColor: Colors.white.withOpacity(0.5),
        //   bottomRightShadowBlur: MaskFilter.blur(BlurStyle.normal, 11.0),
        //   activeLineStroke: 2.0,
        //   activeLineColor: Colors.blueAccent,
        //   inactiveLineColor: Colors.white,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       Icon(
        //         Icons.arrow_back_ios,
        //         color: Colors.white,
        //         size: 10.0,
        //       ),
        //       SizedBox(width: 10.0),
        //       Icon(
        //         Icons.arrow_forward_ios,
        //         color: Colors.white,
        //         size: 10.0,
        //       )
        //     ],
        //   ),
        //   onChanged: (double value) {
        //     setState(() {
        //       value = value;
        //     });
        //   },
        // );

        CupertinoSlider(
            activeColor: Colors.blueAccent,
            // inactiveColor: AppColors.red200,
            // label: inuseAudioinfo.duration.inSeconds.toString(),
            min: 0.0,
            max: ((inuseAudioinfo == null || inuseAudioinfo!.position == null)
                    ? 1
                    : inuseAudioinfo!.position!.inSeconds)
                .toDouble(),
            value: (getSleepkerPosition(
                    (inuseAudioinfo == null || inuseAudioinfo!.position == null)
                        ? 0
                        : inuseAudioinfo!.position!.inSeconds,
                    (inuseAudioinfo == null || inuseAudioinfo!.duration == null)
                        ? 0
                        : inuseAudioinfo!.duration!.inSeconds))
                .toDouble(),
            divisions: 9,
            onChangeStart: (double value) {
              print('Start value is ' + value.toString());
            },
            onChangeEnd: (double value) {
              print('Finish value is ' + value.toString());
            },
            onChanged: (double value) {
              setState(() {
                if (value == inuseAudioinfo!.position!.inSeconds) {
                } else {
                  seekToSecond(value.toInt());
                  value = value;
                }
              });
            });
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.white10,
        inactiveColor: AppColors.red200,
        // label: inuseAudioinfo.duration.inSeconds.toString(),
        min: 0.0,
        max: ((inuseAudioinfo == null || inuseAudioinfo!.position == null)
                ? 0
                : inuseAudioinfo!.position!.inSeconds)
            .toDouble(),
        value: (getSleepkerPosition(
                (inuseAudioinfo == null || inuseAudioinfo!.position == null)
                    ? 0
                    : inuseAudioinfo!.position!.inSeconds,
                (inuseAudioinfo == null || inuseAudioinfo!.duration == null)
                    ? 0
                    : inuseAudioinfo!.duration!.inSeconds))
            .toDouble(),
        // divisions: 5,
        onChangeStart: (double value) {
          print('Start value is ' + value.toString());
        },
        onChangeEnd: (double value) {
          print('Finish value is ' + value.toString());
        },
        onChanged: (double value) {
          setState(() {
            if (value == inuseAudioinfo!.position!.inSeconds) {
            } else {
              seekToSecond(value.toInt());
              value = value;
            }
          });
        });
  }

  int getSleepkerPosition(int max, int value) {
    print("Player Seek Values: Max=" +
        max.toString() +
        " Value=" +
        value.toString());

    if (value >= 0.0 && value <= max) {
      return value;
    } else {
      return max;
    }
  }

  Future<List<MusicData>> downloadSongList(String appname) async {
    // String url = "https://parshtech-songs-jainmusic.s3.us-east-2.amazonaws.com/input.json";
    bool donwloadstatus = false;
    String arrayObjsText = "";
    eos.Response response;
    // '{ "version":1, "tags": [ { "id": 1, "title": "Namp 1", "album": "Flume", "songURL": "https://parshtech-songs-jainmusic.s3.us-east-2.amazonaws.com/Namokar/Namokaar+Mantra+by+Lata+Mangeshkar.mp3", "hindiName": "Testing 1", "favorite": false }, { "id": 2, "title": "Namp 2", "album": "Flume", "songURL": "https://parshtech-songs-jainmusic.s3.us-east-2.amazonaws.com/Namokar/Namokar+Mantra+by+Anurasdha+Paudwal.mp3", "hindiName": "Testing 1", "favorite": false }, { "id": 3, "title": "Namp 3", "album": "Flume", "songURL": "https://parshtech-songs-jainmusic.s3.us-east-2.amazonaws.com/Namokar/Namokaar+Mantra+by+Lata+Mangeshkar.mp3", "hindiName": "Testing 1", "favorite": false } ] }';
    // '{"tags": [{"name": "dart", "quantity": 12}, {"name": "flutter", "quantity": 25}, {"name": "json", "quantity": 8}]}';

    try {
      Dio dio = new Dio();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
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
      // _list = response.data;
      // print(response.data);
      arrayObjsText = response.data;
      // donwloadstatus = true;
      // print(arrayObjsText);
      // arrayObjsText = response.data.toString();
      // print(response.data.toString());
    } catch (e) {
      print(e);
      // print(response);

    }
    // if (donwloadstatus == true) {
    var tagObjsJson = convert.jsonDecode(arrayObjsText)['tags'] as List;
    this.setState(() {
      _list =
          tagObjsJson.map((tagJson) => MusicData.fromJson(tagJson)).toList();
      if (_list!.length > 0) {
        print(_list!.length);
        _list = filterlist(_list!, appname);
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
      setState(() {
        listbuilder = false;
        _mainlist = _list;
        // uiloading();
      });
    });
    // } else {
    //   print("Failed to parse JSON");
    //   var tagObjsJson = convert.jsonDecode(arrayObjsText)['tags'] as List;
    // }
    throw "Song download failed";
  }

  List<MusicData> filterlist(List<MusicData> list, String appname) {
    List<MusicData> newlist = <MusicData>[];
    MusicData listobject;
    print("Filter List for " + appname);
    if (appname.toUpperCase() == "FAVORITE") {
      appname = "DAILY";
    }
    for (int i = 0; i < list.length; i++) {
      if (list[i].album == appname) {
        listobject = list[i];
        newlist.add(listobject);
        // print(list[i]);
      }
    }
    print("Filter List finished for " + appname);
    return newlist;
  }

  Future<List<MusicData>> downloadSongListDB(String appname) async {
    String sql = "";
    try {
      switch (appname.toUpperCase()) {
        // case "FAVORITE":
        //   sql = "select * from songs where isfave=1";
        //   break;
        case "FAVORITE":
          sql = "select * from songs where isfave=1 or album='DAILY'";
          break;
        case "KIDS":
        case "STORY":
          sql = "select * from songs where album='$appname'";
          break;
        default:
          sql = "select * from songs where album='$appname'";
          break;
      }
      // _list = dbHelper.getSong("select * from songs where album='$appname'");
      List<MusicData> list1 = await dbHelper.getSongList(sql);

      // Future<List<MusicData>> list = await list1;
      if (list1 == null || list1.length == 0) {}
      _list = list1;
      setState(() {
        buildListView();
        _mainlist = _list;
        listbuilder = false;
      });
    } catch (e) {
      print(e);
    }
    throw "Failed to load DB Song list";
  }

  int indexfinder(index) {
    for (int i = 0; i < _mainlist!.length; i++) {
      if (_list!.asMap().containsKey(index)) {
        return index;
      } else if (_mainlist![i].id == _list![index].id) {
        return i;
      }
    }
    throw "Failed to find Indexof song";
  }

  Future<void> _player(int index) async {
    FocusScope.of(context).unfocus();

    if (_list!.length != _mainlist!.length) {
      index = indexfinder(index);
      fabsearch = false;
      _list = _mainlist;
    }
    commonmethod.isInternet(context);
    if (inuseAudioinfo!.list == null) {
      inuseAudioinfo!.list = _list;
    }
    if (inuseAudioinfo!.isPlaying! && index != null) {
      if (inuseAudioinfo!.playId == inuseAudioinfo!.list![index].id) {
        // _songId = index;
        pause();
      } else {
        startMusic(index);
      }
    } else {
      if (index == null) {
        if (inuseAudioinfo!.isPlaying!) {
          pause();
        } else {
          if (!inuseAudioinfo!.isPlaying!) {
            if (inuseAudioinfo!.isPause!) {
              pauseplay();
            } else {
              selectMusicNotification();
            }
          }
        }
      } else if (index != null && inuseAudioinfo!.isPause == true) {
        pauseplay();
      } else {
        if (index > inuseAudioinfo!.list!.length - 1) {
          index = 0;
        }
        startMusic(index);
      }
    }
    // fabsearch = false;
    // _list = _mainlist;
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    if (duration != null) {
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return "0.00";
    }
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    // _inuseAudioinfo.audioPlayer.seek(newDuration);
    inuseAudioinfo!.audioPlayer!.seek(newDuration);
  }

  void pause() {
    try {
      inuseAudioinfo!.audioPlayer!.pause();
      // print(inuseAudioinfo.title);
      setState(() {
        // isPlaying = true;
        inuseAudioinfo!.isPause = true;
        inuseAudioinfo!.isPlaying = false;
        inuseAudioinfo = buildData();
      });
    } catch (t) {
      //mp3 unreachable
    }
  }

  void selectMusicNotification() {
    Toast.show(
        selectlang.getAlert("Please select song to play.", lang_selection!),
        duration: 1,
        gravity: 0);
    // commonmethod.displayDialog(
    //   context,
    //   "",
    //   selectlang.getAlert("Please select song to play.", lang_selection),
    //   Icon(
    //     Icons.library_music,
    //     size: 100,
    //     color: AppColors.red200,
    //   ),
    // );
  }

  void pauseplay() {
    try {
      inuseAudioinfo!.audioPlayer!.play();
      // print(inuseAudioinfo.title);
      setState(() {
        // isPlaying = true;
        inuseAudioinfo!.isPause = false;
        inuseAudioinfo!.isPlaying = true;
        inuseAudioinfo = buildData();
      });
    } catch (t) {
      //mp3 unreachable
    }
  }

  void stop() {
    inuseAudioinfo!.audioPlayer!.stop();
    setState(() {
      inuseAudioinfo!.isPlaying = false;
      // inuseAudioinfo.duration = new Duration(seconds: 0);
    });
  }

  Future<void> startMusic(int index) async {
    inuseAudioinfo!.playId = inuseAudioinfo!.list![index].id;
    _songId = index;
    inuseAudioinfo!.playURL = inuseAudioinfo!.list![index].songURL;
    inuseAudioinfo!.title = getSongName(inuseAudioinfo!.list![index]);
    inuseAudioinfo!.songId = index;
    // inuseAudioinfo.playURL =
    //     "https://www.parshtech.com/DATA/AARTI/Vasupujya Bhagwan Ki aarti.mp3";
    try {
      await inuseAudioinfo!.audioPlayer!.open(
          Audio.network(
            inuseAudioinfo!.playURL!,
            metas: Metas(
              title: inuseAudioinfo!.title,
              album: inuseAudioinfo!.appname,
              image: MetasImage.asset(commonmethod.moduleImage(appname)),
            ),
          ),
          showNotification: true,
          notificationSettings: NotificationSettings(
            prevEnabled: false, //disable the previous button
            customNextAction: (player) {
              playnextSong();
              print("Next Song");
            },
            customPlayPauseAction: (player) {
              print("Pause Song");
              if (inuseAudioinfo!.isPlaying!) {
                pause();
              } else {
                pauseplay();
              }
            },
            customPrevAction: (player) {
              print("Previous Song");
            },
            customStopAction: (player) {
              stop();
              print("STOP");
            },
          ));
      print(inuseAudioinfo!.title);
      setState(() {
        // isPlaying = true;
        inuseAudioinfo!.isPause = false;
        inuseAudioinfo!.isPlaying = true;
        inuseAudioinfo = buildData();
      });
    } catch (t) {
      print("Failed to get MP3 data");
      //mp3 unreachable
    }
  }

  String getSongName(MusicData list) {
    if (lang_selection == 1) {
      return list.hindiName;
    } else {
      return list.title;
    }
  }

  getFormatedTime() {
    return (inuseAudioinfo!.duration!.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0.0'));
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
            if (fabsearch!) {
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

  Color getSelectionColor(int index) {
    if (fabsearch == false) {
      if (inuseAudioinfo != null) {
        if (_list![index].id == inuseAudioinfo!.playId &&
            inuseAudioinfo!.appname == appname) {
          return AppColors.activeColor;
        } else {
          return AppColors.mainColor;
        }
      } else {
        return AppColors.mainColor;
      }
    }
    throw "Unable to set selected song color";
  }

  Future<void> downloadSongs(context, String appname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading = true;
    bool firstinstall = false;
    dbversion = prefs.getInt('dbversion');
    eos.Response response;
    String arrayObjsText = "";
    try {
      Dio dio = new Dio();
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient dioClient) {
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

        songlist =
            tagObjsJson.map((tagJson) => MusicData.fromJson(tagJson)).toList();
        dbHelper.buildDB1(songlist!, body['version']);
      }
    } catch (e) {
      Toast.show(
          selectlang.getAlert("Check internet connection", lang_selection!),
          duration: 1,
          gravity: 0);
    }
  }

  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(IterableProperty<MusicData>('_list', _list));
  // }
}
