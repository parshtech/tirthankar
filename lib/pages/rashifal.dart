//import 'dart:html';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
// import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:Tirthankar/core/const.dart';
import 'package:photo_view/photo_view.dart';

class RashiView extends StatefulWidget {
  // int playingId;

  String imagepath;

  // List<MusicData> list;
  RashiView({this.imagepath});

  @override
  _RashiViewState createState() => _RashiViewState(imagepath);
}

class _RashiViewState extends State<RashiView> {
  String imagepath;

  // PDFDocument document;

  _RashiViewState(this.imagepath);

  @override
  void initState() {
    print("This is impage path:" + imagepath);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(primaryColor: Colors.white),
        home: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.styleColor,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            title: Text(
              "Tirthankar",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Container(
            // ignore: deprecated_member_use
            child: Container(
                // height: MediaQuery.of(context).size.width * 1.0,
                // width: MediaQuery.of(context).size.width * 1.0,
                // padding: EdgeInsets.all(16.0),
                child: PhotoView(
              imageProvider: AssetImage(imagepath),
            )
                // child: PinchZoomImage(
                //   image: Image.asset(imagepath),
                //   zoomedBackgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
                //   hideStatusBarWhileZooming: true,
                //   onZoomStart: () {
                //     print('Zoom started');
                //   },
                //   onZoomEnd: () {
                //     print('Zoom finished');
                //   },
                // ),
                ),

            // child: Container(
            //   height: MediaQuery.of(context).size.width * 1.0,
            //   width: MediaQuery.of(context).size.width * 1.0,
            //   ZoomableImage(new AssetImage('images/squirrel.jpg'), scale: 16.0)

            //   // decoration: BoxDecoration(
            //   //   image: DecorationImage(
            //   //     image: AssetImage(imagepath),
            //   //     fit: BoxFit.fill,
            //   //   ),
            //   //   shape: BoxShape.rectangle,
            //   // ),
            // ),
          ),
        ),
      );
}
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(home: Scaffold(body: Column(children: <Widget>[
//      Expanded(child: Center(
//        child: _isInit ? Text('Press Button to Load')
//            : _isLoading
//        ? Center(
//          child: CircularProgressIndicator(),
//        )
//        :PDFViewer(document: document,
//        )
//      ),
//      ),
//      Row(
//        mainAxisSize: MainAxisSize.max,
//        children: <Widget>[
//          Expanded(child: MaterialButton(
//            child: Text('URL'),
//            onPressed: (){
//              loadFromAssets();
//            },
//          ))
//        ],
//      )
//
//    ],),),
//
//
//    );
//  }
//  loadFromAssets() async{
//    setState(() {
//      _isInit = false;
//      _isLoading = true;
//    });
//    document = await PDFDocument.fromAsset("assets/10.pdf");
//    setState(() {
//      _isLoading=false;
//    });
//
//  }
//}
