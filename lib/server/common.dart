import 'package:flutter_music/util/request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_music/main.dart';

getSongList() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.get('userId');
    final response =
        await DioUtil.getInstance().post("/user/playlist?uid=$userId", {});
    final data = response.data;
    var homeData = store.state.playState['home'];
    homeData['songlist'] = data['playlist'];
    // dispatch 含有异步操作，数据提交至actions，可用于向后台提交数据
    store.dispatch({'type': 'setHome', 'playload': homeData});
  } catch (e) {
    print('getSongList');
    print(e);
  }
}

getSongDetail(String id) async {
  try {
    final response =
        await DioUtil.getInstance().post('/song/detail?ids=$id', {});
    final data = response.data;
    // if(data['code'] == 200)
    var playData = store.state.playState['playingData'];
    playData['imgUrl'] = data['songs'][0]['al']['picUrl'];
    playData['name'] = data['songs'][0]['name'];
    playData['id'] = data['songs'][0]['id'];
    playData['ar'] = data['songs'][0]['ar'];
    store.dispatch({'type': 'setPlayingData', 'playload': playData});
  } catch (e) {
    print({'errTitle': 'getSongDetailErr', 'err': e});
  }
}

//
getSongUrl(String id) async {
  try {
    final response =
        await DioUtil.getInstance().post('/song/url?id=$id&br=320000', {});
    final data = response.data;
    String url = data['data'][0]['url'];
    url = 'https${url.split('http')[1]}';
    var playData = store.state.playState['playingData'];
    playData['mp3Url'] = url;
    store.dispatch({'type': 'setPlayingData', 'playload': playData});
  } catch (e) {
    print({'errTitle': 'getSongUrlErr', 'err': e});
  }
}

getLyric(String id) async {
  try {
    final response = await DioUtil.getInstance().post('/lyric?id=$id', {});
    final data = response.data;
    String lrc = data['lrc']['lyric'];
    var playData = store.state.playState['playingData'];
    playData['lrc'] = lrc;
    store.dispatch({'type': 'setPlayingData', 'playload': playData});
  } catch (e) {
    print({'errTitle': 'getLyricErr', 'err': e});
  }
}
