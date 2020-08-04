import 'package:Tirthankar/core/const.dart';
import 'package:Tirthankar/widgets/common_methods.dart';
import 'package:Tirthankar/widgets/custom_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Tirthankar/core/keys.dart';
import 'package:Tirthankar/core/language.dart';
import 'package:Tirthankar/widgets/custom_drawer_tile.dart';

class CustomeBuildDrawer extends StatelessWidget {
  final String module;
  final languageSelector selectlang = new languageSelector();
  final common_methods commonmethod = new common_methods();
  CustomeBuildDrawer({
    this.module,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: <Color>[Colors.deepOrange, Colors.orangeAccent])),
            child: Container(
              child: Column(
                children: <Widget>[
                  commonmethod.buildImageBox(
                      80.0, 80.0, 40.0, 'assets/tirthankar.png'),
                  // Material(
                  //   borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  //   elevation: 10,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: CustomButtonWidget(
                  //       image: 'assets/tirthankar.png',
                  //       size: 80,
                  //       // borderWidth: 5,
                  //     ),

                  //     // (Image.asset(
                  //     //   'assets/tirthankar.png',
                  //     //   width: 78,
                  //     //   height: 78,
                  //     //   // fit: BoxFit.cover,
                  //     // ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      selectlang.getAlbum("Tirthankar", lang_selection),
                      style: TextStyle(fontSize: 20, color: AppColors.white),
                    ),
                  ),
                ],
              ),
            )),
        CustomeDrwareTile(impagepath: "assets/diya.png", module: "Aarti"),
        CustomeDrwareTile(impagepath: "assets/bhakt.png", module: "Bhaktambar"),
        CustomeDrwareTile(impagepath: "assets/story.png", module: "Kids"),
        CustomeDrwareTile(impagepath: "assets/bhajan.png", module: "Bhajan"),
        CustomeDrwareTile(impagepath: "assets/namokar.png", module: "Namokar"),
        CustomeDrwareTile(
            impagepath: "assets/vidyasagar.png", module: "Pravchan"),
        CustomeDrwareTile(impagepath: "assets/chalisa.png", module: "Chalisa"),
        CustomeDrwareTile(
            impagepath: "assets/jinvani.png", module: "Jinvani Channel"),
        CustomeDrwareTile(
            impagepath: "assets/jainrasoi.png", module: "Jain Rasoi"),
        CustomeDrwareTile(
            impagepath: "assets/aryanandi.png", module: "Calendar"),
        CustomeDrwareTile(
            impagepath: "assets/favorite.png", module: "Favorite"),
        CustomeDrwareTile(impagepath: "assets/settings.png", module: "Setting"),

        // ListTile(leading: "assets/diya.png", title: "Aarti"],
        // ["assets/bhakt.png", "Bhaktambar"],
        // ["assets/story.png", "Kids"],
        // ["assets/bhajan.png", "Bhajan"],
        // ["assets/namokar.png", "Namokar"],
        // ["assets/vidyasagar.png", "Pravchan"],
        // ["assets/chalisa.png", "Chalisa"],
        // ["assets/jinvani.png", "Jinvani Channel"],
        // ["assets/jainrasoi.png", "Jain Rasoi"],
        // ["assets/aryanandi.png", "Calendar"],
        // ["assets/favorite.png", "Favorite"],
        // ["assets/settings.png", "Setting"]
      ],
    );
  }
}
