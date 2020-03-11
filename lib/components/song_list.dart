import 'package:flutter/material.dart';
import 'package:flutter_music/components/play_bar.dart';
import 'package:flutter_music/util/theme.dart';
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
  List songList = [];
  double start = 0;
  double end = 0;
  ScrollController controller = new ScrollController();

  getSongList(BuildContext context) async {
    try {
      DioUtil.getInstance().get('/recommend/resource', {'limit': 6}, (data) {
        setState(() {
          songList = data['recommend'];
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

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
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
    // controller.addListener(() {

    // });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < 6; i++) {
      children.add(Padding(
          padding: EdgeInsets.only(top: 0, bottom: 16, left: 8, right: 8),
          child: InkWell(
            onTap: () async {
              // print(songList[i]);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('songSheetId', songList[i]['id'].toString());
              Navigator.pushNamed(context, '/songlist');
            },
            child: songList.length > 0 && [i] != null
                ? ImageBlock(songList[i])
                : null,
          )));
    }
    return songList.length > 0
        ? new Container(
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.all(16.0),
                  child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '推荐歌单',
                                  style: TextStyle(
                                      color: MyColor.lightFont,
                                      fontSize: MyFontSize.smallSize),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4),
                                ),
                                Text(
                                  '为你精挑细选',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: MyColor.deepFont,
                                      fontWeight: FontWeight.w500),
                                )
                              ]),
                          flex: 1,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 4, bottom: 4, left: 8, right: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Color(0xffF0F0F0))),
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              '查看更多',
                              style: TextStyle(
                                  color: MyColor.commonFont,
                                  fontSize: MyFontSize.smallSize),
                            ),
                          ),
                        ),
                      ]),
                ),
                new Padding(
                  padding:
                      EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 8),
                  child: Listener(
                      onPointerDown: (PointerDownEvent e) {
                        start = controller.offset;
                      },
                      onPointerUp: (PointerUpEvent e) {
                        end = controller.offset;
                        double distance = end - start;
                        if (distance < 0) {
                          distance = -distance;
                        }
                        double width =
                            MediaQuery.of(context).size.width / 3 - 30;

                        int times = (distance / width).round();
                        if (end > start) {
                          double offset = start + times * width + 16;
                          double scrollWidth = width * 6 + 16 * 6;
                          controller.animateTo(
                              offset > scrollWidth ? scrollWidth : offset,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.ease);
                        } else {
                          double offset = start - times * width - 16;
                          controller.animateTo(offset > 0 ? offset : 0,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.ease);
                        }
                      },
                      child: SingleChildScrollView(
                        controller: controller,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: children,
                        ),
                      )),
                ),
                // PlayBar()
              ],
            ),
          )
        : new Container(
            height: 300, child: new WeSpin(isShow: true, tip: Text('加载中...')));
  }
}
