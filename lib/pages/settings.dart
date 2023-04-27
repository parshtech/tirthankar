import 'package:Tirthankar/widgets/custom_buildDrawer.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:Tirthankar/core/const.dart';
import 'package:Tirthankar/core/language.dart';
import 'package:Tirthankar/models/listdata.dart';
// import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:Tirthankar/widgets/common_methods.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:Tirthankar/core/keys.dart';

class Settings extends StatefulWidget {
  // int playingId;
  // Data data;
  String? appname;

  // List<MusicData> list;
  // Settings({this.appname, this.data});
  Settings({this.appname});
  @override
  _SettingsState createState() => _SettingsState(appname);
}

class _SettingsState extends State<Settings> {
  String? appname;
  // Data data;
  String? appbarTitle;
  String? langtitle;
  int? lang_index;
  final languageSelector selectlang = new languageSelector();
  final common_methods commonmethod = new common_methods();

  // final DBHelper dbHelper = new DBHelper();
  // int playingId = 0;

  // List<MusicData> list;
  _SettingsState(this.appname);
  // print('${playingId}');

  @override
  void initState() {
    currentappname = "HOME";
    // appname = "";
    // lang_index = 0;
    // getLanguage().whenComplete(() => buildListView);

    setState(() {
      appbarTitle = selectlang.getAlbum("Tirthankar", lang_selection!);
      langtitle = selectlang.getAlbum("Language", lang_selection!);
    });
  }

  // Future<int> getLanguage() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   lang_index = prefs.getInt('language') ?? 0;
  //   setState(() {

  //     appbarTitle = selectlang.getAlbum("Tirthankar", lang_selection);
  //     langtitle = selectlang.getAlbum("Language", lang_selection);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonmethod.buildAppBar(context, "CALENDAR"),
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
        body: Stack(children: <Widget>[
          Column(children: <Widget>[
            buildListView(),
          ])
        ]));
  }

  Data buildData() {
    return Data(appname: appname);
  }

  buildListView() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(langtitle != null ? langtitle! : 'Language',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            // if (lang_selection != null) ...[
            ToggleSwitch(
              minWidth: 130.0,
              cornerRadius: 20,
              activeBgColor: [Colors.deepOrange],
              // activeTextColor: AppColors.white,
              inactiveBgColor: AppColors.styleColor,
              // inactiveTextColor: AppColors.white,
              labels: ['English', 'हिन्दी'],
              // activeColors: [AppColors.brown, AppColors.brown],
              initialLabelIndex: lang_selection ?? 0,
              onToggle: (index) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                if (index == 0) {
                  print("set language to english");
                  commonmethod.setSharedPref('language', "", index!);
                  // await prefs.setInt('language', index);
                  setState(() {
                    appbarTitle = selectlang.getAlbum("Tirthankar", index);
                    langtitle = selectlang.getAlbum("Language", index);
                  });
                } else {
                  print("set language to hindi");
                  commonmethod.setSharedPref('language', "", index!);
                  // await prefs.setInt('language', index);
                  setState(() {
                    appbarTitle = selectlang.getAlbum("Tirthankar", index);
                    langtitle = selectlang.getAlbum("Language", index);
                  });
                }
              },
              totalSwitches: 1,
            ),
          ]

          // ],
          ),
    );
  }
}
