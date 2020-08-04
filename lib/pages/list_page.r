// import 'dart:js';

import 'dart:async';

//import 'dart:ffi';

// import 'dart:convert';
import 'dart:convert' as convert;
import 'package:Tirthankar/widgets/custom_buildDrawer.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/cupertino.dart';

import 'package:gradient_app_bar/gradient_app_bar.dart';
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

class ListPage extends StatefulWidget {
  String appname;
  ListPage({this.appname});
  @override
  _ListPageState createState() => _ListPageState(appname);
}

class _ListPageState extends State<ListPage>
    with SingleTickerProviderStateMixin {
  String appname;
  // Data data;
  _ListPageState(this.appname); // List<MusicModel> _list1;
  final sqllitedb dbHelper = new sqllitedb();
  final common_methods commonmethod = new common_methods();
  List<MusicData> _list;
  int _playId;
  int _songId;
  int _favstate;
  bool addRunner = true;
  AudioPlayerState playerState;
  var countdown;
  @override
  void initState() {
    // data = inuseAudioinfo;

    if (inuseAudioinfo == null) {
      inuseAudioinfo = new Data();
      inuseAudioinfo.audioPlayer = AudioPlayer();
      inuseAudioinfo.isPause = false;
      inuseAudioinfo.isRepeat = false;
      inuseAudioinfo.isShuffle = false;
      inuseAudioinfo.isPlaying = false;
      inuseAudioinfo.appname = appname;
      _playId = 0;
      if (kIsWeb) {
        downloadSongList(appname);
      } else {
        this.downloadSongListDB(appname);
      }
    } else if (appname == inuseAudioinfo.appname) {
      _list = inuseAudioinfo.list;
      _playId = inuseAudioinfo.playId;
      _songId = inuseAudioinfo.songId;
    } else {
      if (kIsWeb) {
        downloadSongList(appname);
      } else {
        this.downloadSongListDB(appname);
      }
      _playId = inuseAudioinfo.playId;
      _songId = inuseAudioinfo.songId;
    }
    audioListner();
    super.initState();
  }

  audioListner() {
    inuseAudioinfo.audioPlayer.onAudioPositionChanged
        .listen((Duration _duration) {
      setState(() {
        inuseAudioinfo.duration = _duration;
        print(inuseAudioinfo.duration);
      });
    });
    inuseAudioinfo.audioPlayer.onDurationChanged.listen((Duration _duration) {
      setState(() {
        inuseAudioinfo.position = _duration;
        print(inuseAudioinfo.position);
      });
    });
    inuseAudioinfo.audioPlayer.onPlayerStateChanged
        .listen((AudioPlayerState s) {
      print('Current player state: $s');
      setState(() {
        playerState = s;
        if (playerState == AudioPlayerState.STOPPED) {
          inuseAudioinfo.duration = new Duration(seconds: 0);
          inuseAudioinfo.position = new Duration(seconds: 0);
        }
      });
    });

    inuseAudioinfo.audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        if ((inuseAudioinfo.duration.inSeconds >=
                inuseAudioinfo.position.inSeconds) &&
            inuseAudioinfo.position.inSeconds > 0) {
          playnextSong();
        }
      });
    });
  }

  playnextSong() {
    inuseAudioinfo.position = new Duration();
    print("Song Duration" + (inuseAudioinfo.duration.inSeconds).toString());
    print("Song Position" + (inuseAudioinfo.position.inSeconds).toString());
    inuseAudioinfo.isPlaying = false;
    if (inuseAudioinfo.isRepeat) {
      inuseAudioinfo.songId = _songId;
    } else {
      if (inuseAudioinfo.isShuffle) {
        var element =
            inuseAudioinfo.list[random.nextInt(inuseAudioinfo.list.length)];
        inuseAudioinfo.songId = element.id;
      } else {
        if (inuseAudioinfo.songId < inuseAudioinfo.list.length - 1) {
          inuseAudioinfo.songId = inuseAudioinfo.songId + 1;
        } else if (inuseAudioinfo.songId == inuseAudioinfo.list.length - 1) {
          inuseAudioinfo.songId = 0;
        } else {
          inuseAudioinfo.songId = inuseAudioinfo.songId;
        }
      }
    }
    _player(inuseAudioinfo.songId);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        inuseAudioinfo = buildData();
      },
      child: Scaffold(
        appBar: GradientAppBar(
          elevation: 0,
          backgroundColorStart: Colors.red,
          backgroundColorEnd: Colors.purple,
          // drawer: new Drawer(child: CustomeBuildDrawer()),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (inuseAudioinfo.isPlaying == true ||
                  inuseAudioinfo.isPause == true) {
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
            },
          ),
          title: Text(
            appname,
            style: TextStyle(color: AppColors.white),
          ),
        ),
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
                      commonmethod.buildImageBox(
                          100.0, 100.0, 10.0, commonmethod.moduleImage(appname))
                    ],
                  ),
                ),
                buildListView(),
                // buildPlayerMenu1(),
                buildMusicBar(context)
              ],
            ),
          ],
        ),
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
                          15,
                          commonmethod.moduleImage(inuseAudioinfo != null
                              ? inuseAudioinfo.appname
                              : appname))),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  // child: Expanded(child: slider()),
                  child: kIsWeb ? null : slider(),
                ),
                Center(
                  child: Marquee(
                    child: Text(inuseAudioinfo.title ?? appname,
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
                      top: BorderSide(color: Colors.red[300]),
                      // bottom: BorderSide(color: AppColors.white)
                    )),
                    child: Wrap(
                      spacing: kIsWeb
                          ? MediaQuery.of(context).size.width * 0.1
                          : 25, // space between two icons
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            inuseAudioinfo.isRepeat
                                ? Icons.repeat_one
                                : Icons.repeat,
                            color: inuseAudioinfo.isRepeat
                                ? AppColors.brown
                                : AppColors.black,
                          ),
                          onPressed: () {
                            print("User clicked Repeat one.");
                            if (inuseAudioinfo.playId != null) {
                              Duration seekdur = new Duration(seconds: 10);
                              if (inuseAudioinfo.isRepeat) {
                                setState(() {
                                  inuseAudioinfo.isRepeat = false;
                                });
                              } else {
                                setState(() {
                                  inuseAudioinfo.isRepeat = true;
                                });
                              }
                            } else {
                              commonmethod.displayDialog(
                                context,
                                "",
                                "Please select song to play.",
                                Icon(
                                  Icons.library_music,
                                  size: 100,
                                  color: AppColors.red200,
                                ),
                              );
                            }
                          },
                        ),
                        IconButton(
                            icon: Icon(
                              inuseAudioinfo.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: AppColors.black,
                            ),
                            onPressed: () {
                              _player(_songId);
                            }),
                        IconButton(
                            icon: Icon(
                              Icons.stop,
                              color: AppColors.black,
                            ),
                            onPressed: () {
                              if (inuseAudioinfo.isPlaying) {
                                // _inuseAudioinfo.audioPlayer.stop();
                                inuseAudioinfo.duration =
                                    new Duration(seconds: 0);
                                inuseAudioinfo.audioPlayer.stop();
                                setState(() {
                                  inuseAudioinfo.isPlaying = false;
                                  // position = new Duration(seconds: 0);
                                  // _duration = new Duration();
                                });
                              }

                              // isPlaying = false;
                            }),
                        IconButton(
                            icon: Icon(
                              Icons.shuffle,
                              color: inuseAudioinfo.isShuffle
                                  ? AppColors.brown
                                  : AppColors.black,
                            ),
                            onPressed: () {
                              if (inuseAudioinfo.isShuffle) {
                                setState(() {
                                  inuseAudioinfo.isShuffle = false;
                                });
                              } else {
                                setState(() {
                                  inuseAudioinfo.isShuffle = true;
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
      child: ListView.builder(
        physics:
            BouncingScrollPhysics(), //This line removes the dark flash when you are at the begining or end of list menu. Just uncomment for
        // itemCount: _list.length,
        itemCount: _list == null ? 0 : _list.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, index) {
          _favstate = _list[index].isfave;
          if (inuseAudioinfo != null) {
            if (inuseAudioinfo.songId != null &&
                inuseAudioinfo.appname == appname) {
              child:
              buildAnimatedContainer(inuseAudioinfo.songId);
            }
          }
          return GestureDetector(
            onTap: () {
              if (inuseAudioinfo.appname != appname) {
                inuseAudioinfo.list = _list;
                inuseAudioinfo.songId = index;
                inuseAudioinfo.appname = appname;
              } else {
                inuseAudioinfo.songId = index;
              }

              _songId = index;
              if (_list[index].songURL == null ||
                  _list[index].songURL == "" ||
                  (_list[index].songURL).isEmpty) {
                if (_list[index].songURL != "") {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => Pdfview(
                        appname: appname,
                        pdfpage: _list[index].pdfpage,
                      ),
                    ),
                  );
                } else {
                  commonmethod.displayDialog(
                    context,
                    "",
                    "Unable to play this song.",
                    Icon(
                      Icons.library_music,
                      size: 100,
                      color: AppColors.white54,
                    ),
                  );
                }
              } else {
                _player(index);
              }
            },
            child: buildAnimatedContainer(index),
          );
        },
      ),
    );
  }

  Data buildData() {
    return Data(
        playId: inuseAudioinfo.playId,
        songId: inuseAudioinfo.songId,
        // inuseAudioinfo.audioPlayer: _inuseAudioinfo.audioPlayer,
        audioPlayer: inuseAudioinfo.audioPlayer,
        isPause: inuseAudioinfo.isPause,
        isPlaying: inuseAudioinfo.isPlaying,
        isRepeat: inuseAudioinfo.isRepeat,
        isShuffle: inuseAudioinfo.isShuffle,
        // duration: _duration,
        // position: _position,
        duration: inuseAudioinfo.duration,
        position: inuseAudioinfo.position,
        title: inuseAudioinfo.title,
        albumImage: commonmethod.moduleImage(appname),
        list: _list,
        appname: appname);
  }

  AnimatedContainer buildAnimatedContainer(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      //This below code will change the color of selected area or song being played.
      decoration: BoxDecoration(
        color: _list[index].id == inuseAudioinfo.playId &&
                inuseAudioinfo.appname == appname
            ? AppColors.activeColor
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
                      _list[index].title,
                      softWrap: true,
                      style: TextStyle(
                        color: AppColors.styleColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Text(
                  _list[index].album,
                  style: TextStyle(
                    color: AppColors.styleColor.withAlpha(90),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            new Spacer(),
            if (_list[index].pdfpage != 0)
              IconButton(
                  alignment: Alignment.centerLeft,
                  icon: Icon(
                    Icons.book,
                    color: AppColors.brown200,
                  ),
                  color: AppColors.red200,
                  // alignment: Alignment.centerRight,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Pdfview(
                          appname: appname,
                          pdfpage: _list[index].pdfpage,
                        ),
                      ),
                    );
                    setState(() {});
                  }), // new Spacer(),
            if (!kIsWeb)
              IconButton(
                  icon: Icon(
                      _favstate == 1 ? Icons.favorite : Icons.favorite_border),
                  color: AppColors.red200,
                  onPressed: () {
                    setState(() {
                      if (_list[index].isfave == 1) {
                        _favstate = 0;
                        _list[index].isfave = 0;
                        dbHelper.updateFavorite(_list[index].id, 0);
                        commonmethod.displayDialog(
                          context,
                          "",
                          "Song removed from favorite",
                          Icon(
                            Icons.favorite_border,
                            size: 100,
                            color: AppColors.red200,
                          ),
                        );
                      } else {
                        _favstate = 1;
                        _list[index].isfave = 1;
                        dbHelper.updateFavorite(_list[index].id, 1);
                        commonmethod.displayDialog(
                          context,
                          "",
                          "Song added to favorite",
                          Icon(
                            Icons.favorite,
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
                    inuseAudioinfo.isPlaying &&
                            _list[index].id == _playId &&
                            index == _songId &&
                            inuseAudioinfo.appname == appname
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: AppColors.styleColor,
                  ),
                  onPressed: () {
                    if (_songId == null) {
                      _player(index);
                    } else if (index == _songId) {
                      _player(_songId);
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
              (inuseAudioinfo == null || inuseAudioinfo.duration == null)
                  ? 0
                  : inuseAudioinfo.duration.inSeconds)),
          min: 0.0,
          divisions: 10,
          max: ((inuseAudioinfo == null || inuseAudioinfo.position == null)
                  ? 0
                  : inuseAudioinfo.position.inSeconds)
              .toDouble(),
          value: (getSleepkerPosition(
                  (inuseAudioinfo == null || inuseAudioinfo.position == null)
                      ? 0
                      : inuseAudioinfo.position.inSeconds,
                  (inuseAudioinfo == null || inuseAudioinfo.duration == null)
                      ? 0
                      : inuseAudioinfo.duration.inSeconds))
              .toDouble(),
          onChangeStart: (double value) {
            print('Start value is ' + value.toString());
          },
          onChangeEnd: (double value) {
            print('Finish value is ' + value.toString());
          },
          onChanged: (double value) {
            setState(() {
              if (value == inuseAudioinfo.position.inSeconds) {
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
    return '${h}:${m}:${s}';
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
            max: ((inuseAudioinfo == null || inuseAudioinfo.position == null)
                    ? 1
                    : inuseAudioinfo.position.inSeconds)
                .toDouble(),
            value: (getSleepkerPosition(
                    (inuseAudioinfo == null || inuseAudioinfo.position == null)
                        ? 0
                        : inuseAudioinfo.position.inSeconds,
                    (inuseAudioinfo == null || inuseAudioinfo.duration == null)
                        ? 0
                        : inuseAudioinfo.duration.inSeconds))
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
                if (value == inuseAudioinfo.position.inSeconds) {
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
        max: ((inuseAudioinfo == null || inuseAudioinfo.position == null)
                ? 0
                : inuseAudioinfo.position.inSeconds)
            .toDouble(),
        value: (getSleepkerPosition(
                (inuseAudioinfo == null || inuseAudioinfo.position == null)
                    ? 0
                    : inuseAudioinfo.position.inSeconds,
                (inuseAudioinfo == null || inuseAudioinfo.duration == null)
                    ? 0
                    : inuseAudioinfo.duration.inSeconds))
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
            if (value == inuseAudioinfo.position.inSeconds) {
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
    String url =
        "https://parshtech-songs-jainmusic.s3.us-east-2.amazonaws.com/input.json";
    String arrayObjsText = "";
    // '{ "version":1, "tags": [ { "id": 1, "title": "Namp 1", "album": "Flume", "songURL": "https://parshtech-songs-jainmusic.s3.us-east-2.amazonaws.com/Namokar/Namokaar+Mantra+by+Lata+Mangeshkar.mp3", "hindiName": "Testing 1", "favorite": false }, { "id": 2, "title": "Namp 2", "album": "Flume", "songURL": "https://parshtech-songs-jainmusic.s3.us-east-2.amazonaws.com/Namokar/Namokar+Mantra+by+Anurasdha+Paudwal.mp3", "hindiName": "Testing 1", "favorite": false }, { "id": 3, "title": "Namp 3", "album": "Flume", "songURL": "https://parshtech-songs-jainmusic.s3.us-east-2.amazonaws.com/Namokar/Namokaar+Mantra+by+Lata+Mangeshkar.mp3", "hindiName": "Testing 1", "favorite": false } ] }';
    // '{"tags": [{"name": "dart", "quantity": 12}, {"name": "flutter", "quantity": 25}, {"name": "json", "quantity": 8}]}';
    try {
      eos.Response response;
      Dio dio = new Dio();
      response = await dio.get(
        url,
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
    var tagObjsJson = convert.jsonDecode(arrayObjsText)['tags'] as List;
    this.setState(() {
      _list =
          tagObjsJson.map((tagJson) => MusicData.fromJson(tagJson)).toList();
      if (_list.length > 0) {
        print(_list.length);
        _list = filterlist(_list, appname);
      } else {
        commonmethod.displayDialog(
          context,
          "",
          "Check internet connection",
          Icon(
            Icons.signal_wifi_off,
            size: 100,
            color: AppColors.red200,
          ),
        );
      }
    });
  }

  List<MusicData> filterlist(List<MusicData> list, String appname) {
    List<MusicData> newlist = new List<MusicData>();
    MusicData listobject;
    for (int i = 0; i < list.length; i++) {
      if (list[i].album == appname) {
        listobject = list[i];
        newlist.add(listobject);
        // print(list[i]);
      }
    }
    return newlist;
  }

  Future<List<MusicData>> downloadSongListDB(String appname) async {
    String sql = "";
    try {
      switch (appname.toUpperCase()) {
        case "FAVORITE":
          sql = "select * from songs where isfave=1";
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
      _list = list1;
      setState(() {
        buildListView();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _player(int index) async {
    commonmethod.isInternet(context);
    if (inuseAudioinfo.list == null) {
      inuseAudioinfo.list = _list;
    }
    if (inuseAudioinfo.isPlaying && index != null) {
      if (inuseAudioinfo.playId == inuseAudioinfo.list[index].id) {
        _songId = index;
        inuseAudioinfo.title = inuseAudioinfo.list[index].title;
        inuseAudioinfo.songId = index;
        inuseAudioinfo.title = inuseAudioinfo.list[index].title;

        // int status = await _inuseAudioinfo.audioPlayer.pause();
        int status = await inuseAudioinfo.audioPlayer.pause();

        if (status == 1) {
          setState(() {
            // isPause = true;
            // isPlaying = false;
            inuseAudioinfo.isPause = true;
            inuseAudioinfo.isPlaying = false;
            inuseAudioinfo = buildData();
          });
        }
      } else {
        inuseAudioinfo.playId = inuseAudioinfo.list[index].id;
        _songId = index;
        inuseAudioinfo.playURL = inuseAudioinfo.list[index].songURL;
        inuseAudioinfo.title = inuseAudioinfo.list[index].title;
        // _inuseAudioinfo.audioPlayer.stop();
        // inuseAudioinfo.audioPlayer.stop();
        // inuseAudioinfo.playId = inuseAudioinfo.list[index].id;
        inuseAudioinfo.songId = index;
        inuseAudioinfo.playURL = inuseAudioinfo.list[index].songURL;
        inuseAudioinfo.title = inuseAudioinfo.list[index].title;

        int status = await inuseAudioinfo.audioPlayer
            .play(inuseAudioinfo.playURL)
            .then((value) {
          return value;
        });

        print(inuseAudioinfo.title);
        if (status == 1) {
          setState(() {
            // isPlaying = true;
            inuseAudioinfo.isPlaying = true;
            inuseAudioinfo = buildData();
          });
        }
      }
    } else {
      if (index == null) {
        if (inuseAudioinfo.isPlaying) {
          // _inuseAudioinfo.audioPlayer.pause();
          inuseAudioinfo.audioPlayer.pause();
          setState(() {
            // isPause = true;
            // isPlaying = false;
            inuseAudioinfo.isPause = true;
            inuseAudioinfo.isPlaying = false;

            // inuseAudioinfo = buildData();
          });
        } else {
          if (!inuseAudioinfo.isPlaying) {
            if (inuseAudioinfo.isPause) {
              // _inuseAudioinfo.audioPlayer.resume();
              inuseAudioinfo.audioPlayer.resume();
              // isPlaying = true;
              setState(() {
                // isPause = false;
                // isPlaying = true;
                inuseAudioinfo.isPause = false;
                inuseAudioinfo.isPlaying = true;
                inuseAudioinfo = buildData();
              });
            } else {
              commonmethod.displayDialog(
                context,
                "",
                "Please select song to play.",
                Icon(
                  Icons.library_music,
                  size: 100,
                  color: AppColors.red200,
                ),
              );
            }
          }
        }
      } else if (index != null && inuseAudioinfo.isPause == true) {
        // _inuseAudioinfo.audioPlayer.resume();
        inuseAudioinfo.audioPlayer.resume();
        // isPlaying = true;
        setState(() {
          // isPause = false;
          // isPlaying = true;
          inuseAudioinfo.isPause = false;
          inuseAudioinfo.isPlaying = true;
          inuseAudioinfo = buildData();
        });
      } else {
        if (index > inuseAudioinfo.list.length - 1) {
          index = 0;
        }
        inuseAudioinfo.playURL = inuseAudioinfo.list[index].songURL;
        _playId = inuseAudioinfo.list[index].id;
        _songId = index;
        inuseAudioinfo.playURL = inuseAudioinfo.list[index].songURL;
        inuseAudioinfo.title = inuseAudioinfo.list[index].title;
        inuseAudioinfo.playId = inuseAudioinfo.list[index].id;
        inuseAudioinfo.songId = index;
        int status = await inuseAudioinfo.audioPlayer
            .play(inuseAudioinfo.playURL)
            .then((value) {
          return value;
        });

        print(inuseAudioinfo.title);
        if (status == 1) {
          setState(() {
            // _completeSongSubscription.resume();
            // isPlaying = true;
            inuseAudioinfo.isPause = false;
            inuseAudioinfo.isPlaying = true;
            inuseAudioinfo = buildData();
          });
        }
      }
    }
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    // _inuseAudioinfo.audioPlayer.seek(newDuration);
    inuseAudioinfo.audioPlayer.seek(newDuration);
  }

  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(IterableProperty<MusicData>('_list', _list));
  // }
}
