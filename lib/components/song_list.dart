import 'package:flutter/material.dart';
import 'package:weui/weui.dart';
import 'package:flutter_music/components/image_block.dart';
import 'package:flutter_music/util/request.dart';
/***
 * 利用sharedPreferences轻量级的存储类来保存键值对信息
 */
import 'package:shared_preferences/shared_preferences.dart';

class SongList extends StatefulWidget {
  @override
  SongListState createState() => SongListState();
}

class SongListState extends State {
  var songList = [];

  getSongList(BuildContext context) async {
    try {
      DioUtil.getInstance().get('/personalized', {'limit': 6}, (data) {
        setState(() {
          songList = data['result'];
          // this.songList = data['result'];
        });
      }, (error) {
        WeToast.fail(context)(message: error['message']);
      });
    } catch (err) {
      print('getSongList');
      print(err);
      WeToast.fail(context)(message: '未知错误');
    }
  }

  Widget itemBuilder(int index) {
    final item = songList[index];
    // InkWell实现水波纹点击效果
    return InkWell(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('playListId', item['id'].toString());
        Navigator.of(context).pushNamed('/playlist');
      },
      child: new Padding(
          padding: EdgeInsets.only(top: 0, bottom: 16, left: 8, right: 8),
          child: ImageBlock(item)),
    );
  }

  @override
  void initState() {
    super.initState();
    getSongList(context);
  }

  @override
  Widget build(BuildContext context) {
    return songList.length > 0
        ? new Container(
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.all(16.0),
                  child: new Row(children: <Widget>[
                    new Expanded(
                      child: Text('推荐歌单', style: TextStyle(fontSize: 18.0)),
                      flex: 1,
                    ),
                    WeButton(
                      '歌单广场',
                      size: WeButtonSize.mini,
                      onClick: () {
                        Navigator.of(context).pushNamed('/square');
                      },
                    )
                  ]),
                ),
                new Padding(
                  padding:
                      EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
                  child: WeGrid(
                    count: 3,
                    itemCount: 6,
                    border: BorderSide.none,
                    itemBuilder: itemBuilder,
                  ),
                )
              ],
            ),
          )
        : new Container(
            height: 300, child: new WeSpin(isShow: true, tip: Text('加载中...')));
  }
}
