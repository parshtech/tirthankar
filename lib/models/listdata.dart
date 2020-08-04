// import 'package:audioplayers/audioplayers.dart';
// import 'package:just_audio/just_audio.dart';

import 'package:assets_audio_player/assets_audio_player.dart';

import 'music.dart';

class Data {
  String appname;
  int playingId;
  List<MusicData> list;
  bool isPlaying = false;
  int playId;
  int songId;
  String playURL;
  String title;
  bool isRepeat;
  bool isShuffle;
  String albumImage;
  Duration duration = new Duration();
  Duration position = new Duration();
  // AudioPlayer audioPlayer = AudioPlayer();
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  // AudioPlayer audioPlayers = AudioPlayer();

  bool isPause;
  Data(
      {this.appname,
      this.playingId,
      this.isPlaying,
      this.audioPlayer,
      this.duration,
      this.isRepeat,
      this.isShuffle,
      this.isPause,
      this.playId,
      this.position,
      this.songId,
      this.list,
      this.title,
      this.albumImage});
}
