// import 'dart:js';

import 'dart:async';

import 'package:Tirthankar/core/const.dart';
import 'package:Tirthankar/core/dbmanager.dart';
import 'package:Tirthankar/widgets/common_methods.dart';
// import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:Tirthankar/pages/home.dart';
import 'package:Tirthankar/pages/rashifal.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  String appname;

  CalendarPage({this.appname});
  @override
  _CalendarPageState createState() => _CalendarPageState(appname);
}

class _CalendarPageState extends State<CalendarPage>
    with SingleTickerProviderStateMixin {
  String appname;
  int _index = 0;
  int cur_month;
  String currentmonth;
  String prevmonth;
  String nextmonth;
  bool rashifal = false;

  List months = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
  ];
  static var now = new DateTime.now();

  _CalendarPageState(this.appname); // List<MusicModel> _list1;
  final sqllitedb dbHelper = new sqllitedb();
  final common_methods commonmethod = new common_methods();
  PageController pageController = PageController(initialPage: now.month - 1);
  @override
  void initState() {
    cur_month = now.month;
    currentmonth = months[cur_month - 1];
    prevmonth = months[cur_month - 2];
    nextmonth = months[cur_month];
    print(months[cur_month - 1]);
    // var date = DateTime.now();
    // var prevMonth = new DateTime(date.month - 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.styleColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          child: Icon(Icons.assistant),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RashiView(
                    imagepath: "assets/" + currentmonth + "_rashi.png"),
              ),
            );
          },
        ),
      ),
      // FloatingActionButton(
      //       heroTag: FloatingActionButtonLocation.endFloat,
      //       onPressed: () {
      //         Navigator.of(context).push(
      //           MaterialPageRoute(
      //             builder: (_) => RashiView(
      //                 imagepath: "assets/" + currentmonth + "_rashi.png"),
      //           ),
      //         );
      //       }),
      // backgroundColor: themeData.scaffoldBackgroundColor,
      backgroundColor: AppColors.mainColor,
      body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            _index = index;
            currentmonth = months[index];
            print("This is current month:" + currentmonth);
          },
          children: <Widget>[
//            Center()
            buildCalendar(context, "jan"),
            buildCalendar(context, "feb"),
            buildCalendar(context, "mar"),
            buildCalendar(context, "apr"),
            buildCalendar(context, "may"),
            buildCalendar(context, "jun"),
            buildCalendar(context, "jul"),
            buildCalendar(context, "aug"),
            buildCalendar(context, "sep"),
            buildCalendar(context, "oct"),
            buildCalendar(context, "nov"),
            buildCalendar(context, "dec"),
          ]),
    );
  }

  Column buildCalendar(BuildContext context, String currentmonth) {
    return Column(
      children: <Widget>[
        // addRunner ?

        Container(
          height: MediaQuery.of(context).size.width * (kIsWeb ? 0.1 : 0.3),
          width: MediaQuery.of(context).size.width * (kIsWeb ? 0.5 : 1.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/" + currentmonth + "_header.png"),
              fit: BoxFit.fill,
            ),
            shape: BoxShape.rectangle,
          ),
        ),
        buildCalRow(
            'assets/sunday.png',
            "assets/" + currentmonth + "_row_1_col_1.png",
            "assets/" + currentmonth + "_row_1_col_2.png",
            "assets/" + currentmonth + "_row_1_col_3.png",
            "assets/" + currentmonth + "_row_1_col_4.png",
            "assets/" + currentmonth + "_row_1_col_5.png"),
        buildCalRow(
            'assets/monday.png',
            "assets/" + currentmonth + "_row_2_col_1.png",
            "assets/" + currentmonth + "_row_2_col_2.png",
            "assets/" + currentmonth + "_row_2_col_3.png",
            "assets/" + currentmonth + "_row_2_col_4.png",
            "assets/" + currentmonth + "_row_2_col_5.png"),
        buildCalRow(
            'assets/tuesday.png',
            "assets/" + currentmonth + "_row_3_col_1.png",
            "assets/" + currentmonth + "_row_3_col_2.png",
            "assets/" + currentmonth + "_row_3_col_3.png",
            "assets/" + currentmonth + "_row_3_col_4.png",
            "assets/" + currentmonth + "_row_3_col_5.png"),
        buildCalRow(
            'assets/wednesday.png',
            "assets/" + currentmonth + "_row_4_col_1.png",
            "assets/" + currentmonth + "_row_4_col_2.png",
            "assets/" + currentmonth + "_row_4_col_3.png",
            "assets/" + currentmonth + "_row_4_col_4.png",
            "assets/" + currentmonth + "_row_4_col_5.png"),
        buildCalRow(
            'assets/thursday.png',
            "assets/" + currentmonth + "_row_5_col_1.png",
            "assets/" + currentmonth + "_row_5_col_2.png",
            "assets/" + currentmonth + "_row_5_col_3.png",
            "assets/" + currentmonth + "_row_5_col_4.png",
            "assets/" + currentmonth + "_row_5_col_5.png"),
        buildCalRow(
            'assets/friday.png',
            "assets/" + currentmonth + "_row_6_col_1.png",
            "assets/" + currentmonth + "_row_6_col_2.png",
            "assets/" + currentmonth + "_row_6_col_3.png",
            "assets/" + currentmonth + "_row_6_col_4.png",
            "assets/" + currentmonth + "_row_6_col_5.png"),
        buildCalRow(
            'assets/saturday.png',
            "assets/" + currentmonth + "_row_7_col_1.png",
            "assets/" + currentmonth + "_row_7_col_2.png",
            "assets/" + currentmonth + "_row_7_col_3.png",
            "assets/" + currentmonth + "_row_7_col_4.png",
            "assets/" + currentmonth + "_row_7_col_5.png"),

        // GestureDetector(
        //     onTap: () {

        //       setState(() {
        //         rashifal = true;
        //       });
        //       displayDate(
        //           context, "assets/" + currentmonth + "_rashi.png", 0.9);
        //       // displayDate(context, impagePath);
        //       print("Display Rashifal");
        //     },
        //     child: Container(
        //       // color: AppColors.darkBlue,
        //       height: MediaQuery.of(context).size.height * 0.05,
        //       width: MediaQuery.of(context).size.width * 1.0,
        //       child: Center(
        //         child: Text(
        //           "Rashifal",
        //           style: TextStyle(
        //             color: AppColors.styleColor,
        //             fontSize: 16,
        //           ),
        //         ),
        //       ),
        //     ))
      ],
    );
  }

  Container buildCalRow(String day, String col1, String col2, String col3,
      String col4, String col5) {
    return Container(
      height: MediaQuery.of(context).size.width * (kIsWeb ? 0.05 : 0.20),
      width: MediaQuery.of(context).size.width * (kIsWeb ? 0.5 : 1.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        buildRowDay(day),
        buildColumnDate(col1),
        buildColumnDate(col2),
        buildColumnDate(col3),
        buildColumnDate(col4),
        buildColumnDate(col5),
      ]),
    );
  }

  Column buildRowDay(String imagePath) {
    return Column(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.width * (kIsWeb ? 0.05 : 0.2),
        width: MediaQuery.of(context).size.width * (kIsWeb ? 0.05 : 0.1),
//        height: MediaQuery.of(context).size.height * 0.1,
//        width: MediaQuery.of(context).size.width * 0.1,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.red200,
          ),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.fill,
          ),
          shape: BoxShape.rectangle,
        ),
      )
    ]);
  }

  Column buildColumnDate(String impagePath) {
    return Column(children: <Widget>[
      GestureDetector(
        onTap: () {
          displayDate(context, impagePath, 0.5);
          // print("Click event on Container");
        },
        child: Container(
//          height: MediaQuery.of(context).size.height * 0.1,
//          width: MediaQuery.of(context).size.width * 0.18,
          height: MediaQuery.of(context).size.width * (kIsWeb ? 0.05 : 0.2),
          width: MediaQuery.of(context).size.width * (kIsWeb ? 0.09 : 0.18),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.red200,
            ),
            // borderRadius: BorderRadius.only(topLeft: 1),
            image: DecorationImage(
              image: AssetImage(impagePath),
              fit: BoxFit.fill,
            ),
            // shape: BoxShape.,
          ),
        ),
      )
    ]);
  }

  displayRashi(BuildContext context, String imagepath) {
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
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagepath),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.rectangle,
            ),
          ),
          actions: <Widget>[MaterialButton(onPressed: () {})],
          elevation: 50,
        );
      },
    );
  }

  displayDate(BuildContext context, String imagepath, double height) {
    // flutter defined function
    showDialog(
      barrierDismissible: true,

      // barrierColor: Colors.black.withOpacity(0.5),
      // transitionDuration: Duration(milliseconds: 700),
      context: context,
      builder: (context) {
        // Navigator.of(context).pop(true);
        // Future.delayed(Duration(seconds: 1), () {
        //   Navigator.of(context).pop(true);
        // });

        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          contentPadding: EdgeInsets.only(top: 5.0),
          backgroundColor: AppColors.styleColor,
          content: Container(
            height: MediaQuery.of(context).size.height * height,
            width: MediaQuery.of(context).size.width * (kIsWeb ? 0.4 : 1.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagepath),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.rectangle,
            ),
          ),
          elevation: 50,
          // actions: <Widget>[
          //   Center(
          //     child: MaterialButton(
          //         elevation: 10,
          //         child: Text("Back"),
          //         onPressed: () {
          //           Navigator.of(context).pop(true);
          //         }),
          //   )
          // ],
        );
      },
    );
  }

  // user defined function

}
