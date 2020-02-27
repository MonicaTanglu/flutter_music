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
