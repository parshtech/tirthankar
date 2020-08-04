import 'package:Tirthankar/core/const.dart';
import 'package:Tirthankar/core/keys.dart';
import 'package:Tirthankar/models/listdata.dart';
import 'package:Tirthankar/models/music.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Tirthankar/widgets/common_methods.dart';

class CustomeDrwareTile extends StatelessWidget {
  final String impagepath;
  final String module;
  final common_methods commonmethod = new common_methods();
  CustomeDrwareTile({
    this.impagepath,
    this.module,
  });

  Data buildData(String appname, List<MusicData> _list) {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.styleColor))),
        child: InkWell(
            splashColor: Colors.orangeAccent,
            onTap: () {
              commonmethod.tileAction(context, module);
            },
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      commonmethod.buildImageBox(40.0, 40.0, 5.0, impagepath),
                      // Image.asset(
                      //   impagepath,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          module,
                          style: TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  ),
                  // Image.asset(
                  //   impagepath,
                  // ),
                ],
              ),
            )),
      ),
    );
  }
}
