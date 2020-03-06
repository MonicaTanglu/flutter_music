import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_music/main.dart';
import 'package:flutter_music/server/common.dart';

// 播放控制器
class PlayerController {
  AudioPlayer audioPlayer;
  int index = store.state.playState['playingData']['index'];
  final playlist = store.state.playState['playingData']['playList'];

  PlayerController() {
    _init();
  }

  _init() {
    audioPlayer = store.state.playState['playingData']['controller'];
    if (audioPlayer == null) {
      store.state.playState['playingData']['controller'] = new AudioPlayer();
      audioPlayer = store.state.playState['playingData']['controller'];
      audioPlayer.setVolume(1);
    }
  }

  _playByIndex() async {
    String id = playlist[index]['id'].toString();
    await getSongDetail(id);
    await getSongUrl(id);
    await getLyric(id);
    store.dispatch({'type': 'changePlay', 'playload': 'play'});
    store.dispatch({
      'type': 'setPlayingData',
      'playload': {'index': index}
    });
  }

  void onDurationChanged(Function callback) {
    audioPlayer.onDurationChanged.listen(callback);
  }

  void onAudioPositionChanged(Function callback) {
    audioPlayer.onAudioPositionChanged.listen(callback);
  }

  void onPlayerStateChanged(Function callback) {
    audioPlayer.onPlayerStateChanged.listen(callback);
  }

  void play(String url) async {
    await audioPlayer.play(url);
  }

  void pause() async {
    await audioPlayer.pause();
  }

  void resume() async {
    await audioPlayer.resume();
  }

  void stop() async {
    await audioPlayer.stop();
  }

  void destroy() async {
    audioPlayer = null;
  }

  void next() async {
    if (index < playlist.length - 1) {
      index++;
    } else
      index = 0;
    try {
      _playByIndex();
    } catch (e) {
      next();
    }
  }

  void prev() async {
    if (index > 0) {
      index--;
    } else {
      index = playlist.length - 1;
    }
    try {
      _playByIndex();
    } catch (e) {
      prev();
    }
  }
}
