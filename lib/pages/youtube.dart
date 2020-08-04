import 'package:Tirthankar/pages/videoplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:Tirthankar/core/const.dart';
import 'package:Tirthankar/core/keys.dart';
import 'package:Tirthankar/models/listdata.dart';
import 'package:Tirthankar/pages/home.dart';
import 'package:Tirthankar/pages/muni.dart';
// import 'package:Tirthankar/pages/videoplay.txt';
import 'package:Tirthankar/pages/youtubeapi.dart';
import 'package:Tirthankar/widgets/common_methods.dart';
import 'package:Tirthankar/core/language.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// import 'package:youtube_player_web/youtube_player_web.dart';

// void main() => runApp(new YoutubePlay());

class YoutubePlay extends StatefulWidget {
  String appname;
  String search;
  // // int playingId;
  // // List<MusicData> list;
  // // ListPage({this.appname,this.playingId,this.list});
  // Data data;
  // YoutubePlay({this.appname, this.data});
  YoutubePlay({this.appname, this.search});
  @override
  _YoutubePlayState createState() => new _YoutubePlayState(appname, search);
}

class _YoutubePlayState extends State<YoutubePlay> {
  static String key = YOUTUBE_KEY; // ** ENTER YOUTUBE API KEY HERE **
  String appname;
  String search;
  String songid;
  String query;
  int videolist = 0;
  bool _isLoading = false;
  ScrollController _controller;
  _YoutubePlayState(this.appname, this.search);
  YoutubeAPIA ytApi = new YoutubeAPIA(key);
  List<YT_API> ytResult = [];
  final languageSelector selectlang = new languageSelector();
  final common_methods commonmethod = new common_methods();
  YoutubePlayerController _controllers;

  callAPI() async {
    print('UI callled');
    query = search;
    // ytResult = await ytApi.search(query);
    if (internet != false) {
      ytResult = await ytApi.searchVideo(query);
    }

    setState(() {
      print('UI Updated');
    });
  }

  setup() {
    commonmethod.isInternet(context);
    callAPI();
    setState(() {
      videolist = ytResult.length;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setup());

    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    _controllers = YoutubePlayerController(
      initialVideoId: songid,
      params: const YoutubePlayerParams(
        startAt: const Duration(seconds: 30),
        showControls: true,
        showFullscreenButton: true,
      ),
    )..listen((event) {
        //log(event.toString());
      });
    _controllers.onEnterFullscreen = () => print('Entered Fullscreen');
    _controllers.onExitFullscreen = () {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      Future.delayed(const Duration(seconds: 1), () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      });
      print('Exited Fullscreen');
    };

    print('hello');
  }

  _loadMoreVideos() async {
    _isLoading = true;
    // List<Video> moreVideos = await APIService.instance
    //     .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    // List<YT_API> moreVideos = await ytApi.nextPage();
    List<YT_API> moreVideos = await ytApi.searchVideo(query);
    // print(moreVideos.toString());
    // uniqueList(moreVideos);
    // List<YT_API> ytResultLoaded = ytResult..addAll(moreVideos);
    List<YT_API> ytResultLoaded = uniqueList(moreVideos);

    setState(() {
      ytResult = ytResultLoaded.toSet().toList();
    });
    _isLoading = false;
  }

  List<YT_API> uniqueList(List<YT_API> input) {
    List<YT_API> ytResultLoaded = ytResult;
    for (int j = 0; j < input.length; j++) {
      String videoid = input[j].id;
      bool idfound = false;
      for (int i = 0; i < ytResultLoaded.length; i++) {
        if (input[j].id == ytResultLoaded[i].id) {
          idfound = true;
        }
      }
      if (idfound != true) {
        ytResultLoaded.add(input[j]);
      }
    }
    return ytResultLoaded;
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      _loadMoreVideos();
      setState(() {
        print("reach the bottom");
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        print("reach the top");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // home: new Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.styleColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Route route;
            switch (appname) {
              case "Pravchan":
                route = MaterialPageRoute(
                  builder: (_) => MuniPage(),
                );
                break;
              case "Jain Rasoi":
                route = MaterialPageRoute(
                  builder: (_) => HomePage(),
                );
                break;
              default:
                route = MaterialPageRoute(
                  builder: (_) => HomePage(),
                );
            }
            Navigator.of(context).push(route);
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (_) => MuniPage(
            //       appname: appname,
            //       // data: ndata,
            //     ),
            //   ),
            // );
          },
        ),
        title: Text(
          selectlang.getAlbum("Tirthankar", lang_selection),
          style: TextStyle(color: AppColors.white),
        ),
      ),
      backgroundColor: AppColors.mainColor,
      body: videolist == 0
          ? new Container(
              child: ListView.builder(
                controller: _controller,
                // shrinkWrap: true,
                // itemCount: appname.contains("Live") ? 1 : ytResult.length,
                itemCount: ytResult.length,
                itemBuilder: (_, int index) => listCardView(index),
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor, // Red
                ),
                // commonmethod.isInternet(context),
              ),
            ),

      // body: ytResult != null
      //     ? NotificationListener<ScrollNotification>(
      //         onNotification: (ScrollNotification scrollDetails) {
      //           if (!_isLoading && ytResult.length != ytResult[0].totalresult && scrollDetails.metrics.pixels ==
      //                   scrollDetails.metrics.maxScrollExtent) {
      //             _loadMoreVideos();
      //           }
      //           return false;
      //         },
      //         child: ListView.builder(
      //           itemCount: ytResult.length,
      //           itemBuilder: (_, int index) => listCardView(index),
      //           // itemCount: 1 + _channel.videos.length,
      //           // itemBuilder: (BuildContext context, int index) {
      //           //   if (index == 0) {
      //           //     return _buildProfileInfo();
      //           //   }
      //           //   Video video = _channel.videos[index - 1];
      //           //   return _buildVideo(video);
      //           // },
      //         ),
      //       )
      //     : Center(
      //         child: CircularProgressIndicator(
      //           valueColor: AlwaysStoppedAnimation<Color>(
      //             Theme.of(context).primaryColor, // Red
      //           ),
      //         ),
      //       ),
      // ),
    );
  }

  Data buildData() {
    return Data(
        playId: null,
        songId: null,
        audioPlayer: null,
        isPlaying: null,
        isRepeat: null,
        isShuffle: null,
        duration: null,
        position: null,
        list: null,
        appname: appname);
  }

  Widget listItem(index) {
    return new Card(
      color: AppColors.mainColor,
      child: new Container(
        margin: EdgeInsets.symmetric(vertical: 7.0),
        padding: EdgeInsets.all(5.0),
        child: new Row(
          children: <Widget>[
            new Image.network(
              ytResult[index].thumbnail['default']['url'],
            ),
            new Padding(padding: EdgeInsets.only(right: 20.0)),
            new Expanded(
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  new Text(
                    ytResult[index].title,
                    softWrap: true,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  new Padding(padding: EdgeInsets.only(bottom: 1.5)),
                  new Text(
                    ytResult[index].channelTitle,
                    softWrap: true,
                  ),
                  new Padding(padding: EdgeInsets.only(bottom: 3.0)),
                  // new Text(
                  //   ytResult[index].url,
                  //   softWrap: true,
                  // ),
                ]))
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names

  playFullvideo(String id) {}

  playvideo(String id) {
    // FlutterYoutube.playYoutubeVideoById(
    //     apiKey: YOUTUBE_KEY,
    //     videoId: id,
    //     autoPlay: true, //default falase
    //     fullScreen: true //default false
    //     );
  }

  Widget listCardView(index) {
    // if (ytResult[index].kind == "video") {
    return GestureDetector(
      // height: MediaQuery.of(context).size.width * (kIsWeb ? 0.5 : 0.8),
      // width: MediaQuery.of(context).size.width * (kIsWeb ? 0.05 : 1),
      // height: 320,
      // margin: EdgeInsets.only(bottom: 1),
      child: InkWell(
        onTap: () {
          songid = ytResult[index].id;
          // ignore: close_sinks
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => YoutubeAppDemo(
                id: ytResult[index].id,
                appname: appname,
                // data: ndata,
              ),
            ),
          );

          // playFullvideo(ytResult[index].id);
          // playvideo(ytResult[index].id);
          // FlutterYoutube.playYoutubeVideoById(
          //     apiKey: YOUTUBE_KEY,
          //     videoId: ytResult[index].id,
          //     autoPlay: true, //default falase
          //     fullScreen: true //default false
          //     );
        },
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 0.1, right: 0.1),
              child: Container(
                height:
                    MediaQuery.of(context).size.width * (kIsWeb ? 0.3 : 0.7),
                width: MediaQuery.of(context).size.width * (kIsWeb ? 0.7 : 1),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                        NetworkImage(ytResult[index].thumbnail['high']['url']),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.width * (kIsWeb ? 0.05 : 0.1),
              width: MediaQuery.of(context).size.width * (kIsWeb ? 0.4 : 1),
              margin: EdgeInsets.only(left: 10, top: kIsWeb ? 2 : 5, bottom: 1),
              child: new Row(
                  // new Padding(padding: EdgeInsets.only(left: 10,right: 10)),
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      // new Padding(padding: EdgeInsets.only(left: 10,right: 10)),
                      child: Marquee(
                        child: Text(
                          ytResult[index].title,
                          softWrap: true,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ]),
            ),

            // Container(
            //   margin: EdgeInsets.only(left: 10, top: 1, bottom: 1),
            //   // height: 70,
            //   child: Row(
            //     children: <Widget>[
            //   new Padding(padding: EdgeInsets.only(right: 0.2)),
            //   new Expanded(child: new Column(
            //     // mainAxisAlignment: MainAxisAlignment.start,
            //     // crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Marquee(child: Text(
            //         ytResult[index].title,
            //         softWrap: true,
            //         style: TextStyle(fontSize:18.0),
            //       ),),
            //       // new Padding(padding: EdgeInsets.only(bottom: 1.5)),
            //       // new Text(
            //       //   ytResult[index].channelTitle,
            //       //   softWrap: true,
            //       // ),
            //       // new Padding(padding: EdgeInsets.only(bottom: 3.0)),
            //       // new Text(
            //       //   ytResult[index].url,
            //       //   softWrap: true,
            //       // ),
            //     ]
            //   )),

            //     // // // children: <Widget> [
            //     // // //   Column(
            //     // // //     children: <Widget>[
            //     // // //       Container(
            //     // // //         height: 35,
            //     // // //         // child: CircleAvatar(backgroundImage: ytResult[index].thumbnail['default']['url'],),
            //     // // //       ),
            //     // // //       Container()
            //     // // //     ],
            //     // // //   ),
            //     // // //   Container(
            //     // // //     margin: EdgeInsets.only(left: 10),
            //     // // //     child: SizedBox(
            //     // // //         height: 80,
            //     // // //         child: Column(
            //     // // //         crossAxisAlignment: CrossAxisAlignment.start,
            //     // // //         children: <Widget>[
            //     // // //           Expanded(child: Marquee(child: Text(ytResult[index].title, style: TextStyle(fontSize:18.0),),)
            //     // // //           ),
            //     // // //           // Text(ytResult[index].title, style: TextStyle(fontSize:18.0),),
            //     // // //           Container(
            //     // // //             child: Row(
            //     // // //               children: <Widget>[
            //     // // //                 Text(ytResult[index].channelId, style: TextStyle(fontSize:10.0),),
            //     // // //                 Text(" ∙ ", style: TextStyle(fontSize:18.0),),
            //     // // //                 // Text(video.getViewCount() + " views", style: TextStyle(fontSize:18.0),),
            //     // // //                 // Text(" ∙ ", style: videoInfoStyle,),
            //     // // //                 Text(ytResult[index].publishedAt + " ago", style: TextStyle(fontSize:10.0),),
            //     // // //               ],
            //     // // //             ),
            //     // // //           )
            //     // // //         ],
            //     // //       ),
            //     // //     ),
            //     //   )
            //     ]
            //   ),
            // )
          ],
        ),
      ),
    );
    // }
  }
}
