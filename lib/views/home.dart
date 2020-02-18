import 'package:flutter/material.dart';
import 'package:flutter_music/components/box.dart';
import 'package:weui/weui.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State with AutomaticKeepAliveClientMixin {
  var _listFont = const TextStyle(fontSize: 14.0);
  var rightColor = Color(0xff999999);
  var listRight = const TextStyle(fontSize: 12.0, color: Color(0xff999999));
  var userInfo = {};
  var _userId;
  var playList = [];
  List<Widget> playListWifget = [];
  List<Widget> collectWifget = [];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const channels = [
      {
        'title': 'ACG专区',
        'icon': const Icon(Icons.brightness_auto, color: Colors.white)
      },
      {
        'title': '最嗨电音',
        'icon': const Icon(
          Icons.grain,
          color: Colors.white,
        )
      },
      {
        'title': 'Sati控件',
        'icon': const Icon(
          Icons.brightness_2,
          color: Colors.white,
        )
      },
      {
        'title': '私藏推荐',
        'icon': const Icon(
          Icons.folder_special,
          color: Colors.white,
        )
      },
      {
        'title': '因乐交友',
        'icon': const Icon(
          Icons.supervised_user_circle,
          color: Colors.white,
        )
      },
      {
        'title': '亲子频道',
        'icon': const Icon(
          Icons.child_friendly,
          color: Colors.white,
        )
      },
      {
        'title': '古典专区',
        'icon': const Icon(
          Icons.queue_music,
          color: Colors.white,
        )
      }
    ];
    List<Widget> children = [];
    for (int index = 0; index < channels.length; index++) {
      children.add(Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      alignment: Alignment.center,
                      width: 40,
                      height: 40,
                      color: Colors.red,
                      child: channels[index]['icon'],
                    ),
                  ),
                  box,
                  Text(channels[index]['title'],
                      style: TextStyle(fontSize: 12.0))
                ],
              ),
            )),
      ));
    }

    return Scaffold(
        body: IndexedStack(
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            child: Column(children: <Widget>[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: 110,
                  color: Colors.white,
                  child: Row(children: children),
                ),
              ),
              Container(
                child: WeCells(
                  boxBorder: true,
                  children: <Widget>[
                    WeCell(
                      label: Row(children: <Widget>[
                        Padding(
                            child: Icon(Icons.queue_music),
                            padding: EdgeInsets.only(right: 12)),
                        Text('本地音乐', style: _listFont)
                      ]),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('0', style: listRight),
                          Padding(
                            child: Icon(Icons.arrow_forward_ios,
                                size: 18, color: rightColor),
                            padding: EdgeInsets.only(left: 2),
                          )
                        ],
                      ),
                    ),
                    WeCell(
                      label: Row(children: <Widget>[
                        Padding(
                            child: Icon(Icons.play_circle_outline),
                            padding: EdgeInsets.only(right: 12)),
                        Text('最近播放', style: _listFont)
                      ]),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text('0', style: listRight),
                          Padding(
                            child: Icon(Icons.arrow_forward_ios,
                                size: 18, color: rightColor),
                            padding: EdgeInsets.only(left: 2),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        )
      ],
    ));
  }
}
