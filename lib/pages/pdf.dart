//import 'dart:html';

import 'package:Tirthankar/core/keys.dart';
import 'package:Tirthankar/widgets/common_methods.dart';
import 'package:Tirthankar/core/language.dart';
import 'package:Tirthankar/widgets/custom_buildDrawer.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
// import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:Tirthankar/core/const.dart';
import 'package:pdfx/pdfx.dart';
import 'package:toast/toast.dart';

class Pdfview extends StatefulWidget {
  // int playingId;
  int? pdfpage;

  String? appname;
  String? filepath;
  // List<MusicData> list;
  Pdfview({this.appname, this.pdfpage, this.filepath});

  @override
  _PdfviewState createState() => _PdfviewState(appname, pdfpage, filepath);
}

class _PdfviewState extends State<Pdfview> {
  String? appname;
  int? pdfpage;
  int? gotopage = 0;
  String? filepath;
  final gotoController = TextEditingController();
  final languageSelector selectlang = new languageSelector();
  // PDFDocument document;
  final common_methods commonmethod = new common_methods();
  _PdfviewState(this.appname, this.pdfpage, this.filepath);

  int _actualPageNumber = 1, _allPagesCount = 0;
  PdfController? _pdfController;

  @override
  void initState() {
    if (appname!.toUpperCase() == "JAIN BOOKS") {
      currentappname = "JAIN BOOKS";
    } else if (appname!.toUpperCase() == "VIDHAN") {
      currentappname = "VIDHAN";
    } else if (appname!.toUpperCase() == "PUJA") {
      currentappname = "PUJA";
    } else {
      currentappname = "LISTPAGE";
      currentMuni = appname;
    }
    print("PDF Page" + pdfpage.toString());
    _pdfController = PdfController(
        document: PdfDocument.openFile(
            filepath!), //.openAsset('assets/jainaarti.pdf'),
        initialPage: pdfpage!);
    // _pdfController.initialPage == pdfpage;
    WidgetsBinding.instance.addPostFrameCallback((_) => openpage());
    super.initState();
  }

  @override
  void dispose() {
    _pdfController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        throw "Failed to go back";
      },
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.white),
        home: Scaffold(
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
          //      appBar: AppBar(
          //        title: Text('PdfView example'),
          //        actions: <Widget>[
          //          IconButton(
          //            icon: Icon(Icons.navigate_before),
          //            onPressed: () {
          //              _pdfController.previousPage(
          //                curve: Curves.ease,
          //                duration: Duration(milliseconds: 100),
          //              );
          //            },
          //          ),
          //          Container(
          //            alignment: Alignment.center,
          //            child: Text(
          //              '$_actualPageNumber/$_allPagesCount',
          //              style: TextStyle(fontSize: 22),
          //            ),
          //          ),
          //          IconButton(
          //            icon: Icon(Icons.navigate_next),
          //            onPressed: () {
          //              _pdfController.nextPage(
          //                curve: Curves.ease,
          //                duration: Duration(milliseconds: 100),
          //              );
          //            },
          //          ),
          //        ],
          //      ),
          body: Stack(children: <Widget>[
            PdfView(
              documentLoader: Center(child: CircularProgressIndicator()),
              pageLoader: Center(child: CircularProgressIndicator()),
              scrollDirection: Axis.vertical,
              controller: _pdfController!,

              // _pdfController.jumpToPage(pdfpage);
              onDocumentLoaded: (document) {
                // _pdfController.jumpToPage(pdfpage);
                setState(() {
                  // _actualPageNumber = pdfpage;
                  _allPagesCount = document.pagesCount;
                });
              },
              onPageChanged: (page) {
                setState(() {
                  _actualPageNumber = page;
                });
              },
            ),
            new Container(
                margin: EdgeInsets.all(8.0),
                height: 50,
                color: AppColors.mainColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.skip_previous,
                        color: AppColors.darkBrown,
                        size: 40,
                      ),
                      onPressed: () {
                        _pdfController!.previousPage(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.ease);
                      },
                    ),

                    Container(
                        color: Colors.white,
                        width: 150.0,
                        height: 40,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: gotoController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Page No',
                          ),
                        )),
                    ElevatedButton(
                        child: Text("GO"),
                        onPressed: () {
                          if (gotoController.text != "" &&
                              int.parse(gotoController.text) < _allPagesCount) {
                            _pdfController!.animateToPage(
                                int.parse(gotoController.text),
                                duration: Duration(milliseconds: 250),
                                curve: Curves.ease);
                            // _pdfController
                            //     .jumpToPage(int.parse(gotoController.text));
                            print(gotoController.text);
                          } else if (int.parse(gotoController.text) >
                              _allPagesCount) {
                            Toast.show(
                                selectlang.getAlert(
                                    "Enter page no less than book page",
                                    lang_selection!),
                                duration: 1,
                                gravity: 0);
                            print("Enter page no less than book page");
                          } else {
                            Toast.show(
                                selectlang.getAlert(
                                    "Please enter Page No", lang_selection!),
                                duration: 1,
                                gravity: 0);
                            print("Please enter Page No");
                          }

                          FocusScope.of(context).unfocus();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                                side: BorderSide(color: Colors.white)))),
                    IconButton(
                      icon: Icon(
                        Icons.skip_next,
                        color: AppColors.darkBrown,
                        size: 40,
                      ),
                      onPressed: () {
                        _pdfController!.nextPage(
                            duration: Duration(milliseconds: 250),
                            curve: Curves.ease);
                      },
                    ),

                    // IconButton(icon: Icons.go, onPressed: null)
                  ],
                ))
          ]),
        ),
      ),
    );
  }

  openpage() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _pdfController!.jumpToPage(pdfpage!);
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
}
