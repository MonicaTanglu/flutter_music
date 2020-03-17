import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/redux/index.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_music/components/box.dart';
// import 'package:weui/weui.dart';
// import 'package:flutter_music/server/api.dart';
import 'package:flutter_music/server/common.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State with AutomaticKeepAliveClientMixin {
  var fontStyle = const TextStyle(fontSize: 12.0, color: Colors.white);
  var rightColor = Color(0xff999999);
  var listRight = const TextStyle(fontSize: 12.0, color: Color(0xff999999));
  var userInfo = {};
  var userId;
  var playList = [];
  List<Widget> playListWifget = [];
  List<Widget> collectWifget = [];

  @override
  bool get wantKeepAlive => true;

  loginState(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get('userId');

    if (userId != null) {
      setState(() {
        userInfo['avatarUrl'] = prefs.get('avatarUrl');
        userInfo['nickname'] = prefs.get('nickname');
      });
    } else {}
  }

  getSongSheet(BuildContext context, dynamic playList) {
    Widget children;
    collectWifget = [];
    playListWifget = [];
    for (int index = 1; index < playList.length; index += 2) {
      // if(playList[index]['trackCount'] == 0) continue;
      children = Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: InkWell(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString(
                              'songSheetId', playList[index]['id'].toString());
                          Navigator.of(context).pushNamed('/songlist');
                        },
                        child: Row(children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: playList[index]['coverImgUrl'],
                                  fit: BoxFit.fill,
                                ),
                              ),
                              width: 48,
                              height: 48,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                playList[index]['name'],
                                style: TextStyle(
                                    color: Color(0xff595959), fontSize: 12),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Text('${playList[index]['trackCount']}首',
                                    style: TextStyle(
                                        color: Color(0xffA5A5A5),
                                        fontSize: 10)),
                              )
                            ],
                          )
                        ]))),
                (index + 1) < playList.length
                    ? Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('songSheetId',
                                  playList[index + 1]['id'].toString());
                              Navigator.of(context).pushNamed('/songlist');
                            },
                            child: Row(children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      imageUrl: playList[index + 1]
                                          ['coverImgUrl'],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  width: 48,
                                  height: 48,
                                ),
                              ),
                              Container(
                                  width: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        playList[index + 1]['name'],
                                        style: TextStyle(
                                            color: Color(0xff595959),
                                            fontSize: 12),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                            '${playList[index + 1]['trackCount']}首',
                                            style: TextStyle(
                                                color: Color(0xffA5A5A5),
                                                fontSize: 10)),
                                      )
                                    ],
                                  ))
                            ])))
                    : Container(
                        child: null,
                      )
              ]));
      if (playList[index]['creator']['userId'].toString() == userId) {
        playListWifget.add(children);
      } else {
        collectWifget.add(children);
      }
      // if (playList[index + 1]['creator']['userId'].toString() == userId) {
      //   playListWifget.add(children);
      // } else {
      //   collectWifget.add(children);
      // }
    }
    return collectWifget.join();
  }

  @override
  void initState() {
    super.initState();
    loginState(context);
    getSongList();
  }

  final home = store.state.playState['home'];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StoreConnector<PlayState, Map>(
      converter: (store) => home,
      builder: (context, play) {
        getSongSheet(context, home['songlist']);
        return Container(
            color: Color(0xff25242A),
            child: SingleChildScrollView(
                child: Column(children: [
              Padding(
                  padding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 16, right: 16),
                  child: Column(children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image(
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                  image: userInfo['avatarUrl'] != null
                                      ? NetworkImage(userInfo['avatarUrl'])
                                      : null,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 6),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Text(userInfo['nickname'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18)),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        color: Color(0xff605F64),
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          'lv.5',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Text(
                            '尊享豪华特权',
                            style: TextStyle(
                                color: Color(0xff7B7B80), fontSize: 10),
                          ),
                        ),
                        Icon(Icons.chevron_right,
                            color: Color(0xff7B7B80), size: 24)
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Column(children: <Widget>[
                              Icon(Icons.arrow_downward,
                                  color: Colors.white, size: 28),
                              box,
                              Text('本地音乐', style: fontStyle)
                            ]),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(children: <Widget>[
                              Icon(Icons.radio, color: Colors.white, size: 28),
                              box,
                              Text('我的电台', style: fontStyle)
                            ]),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(children: <Widget>[
                              Icon(Icons.star_border,
                                  color: Colors.white, size: 28),
                              box,
                              Text('我的收藏', style: fontStyle)
                            ]),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(children: <Widget>[
                              Icon(Icons.fiber_new,
                                  color: Colors.white, size: 28),
                              box,
                              Text('关注新歌', style: fontStyle)
                            ]),
                          )
                        ],
                      ),
                    )
                  ])),
              Container(
                padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                width: double.infinity,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Row(children: [
                        Expanded(flex: 1, child: Text('我的音乐')),
                        Icon(Icons.mood, color: Color(0xffA1A1A1), size: 16),
                        Icon(
                          Icons.chevron_right,
                          color: Color(0xffA1A1A1),
                          size: 30,
                        )
                      ]),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(right: 10),
                            height: 120,
                            decoration: BoxDecoration(
                                color: Color(0xff878787),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 6,
                                  ),
                                  child: Icon(Icons.mood,
                                      color: Colors.white, size: 20),
                                ),
                                Text(
                                  '我喜欢的音乐',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            height: 120,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                color: Color(0xff878787),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 6,
                                  ),
                                  child: Icon(Icons.mood,
                                      color: Colors.white, size: 20),
                                ),
                                Text(
                                  '私人FM',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            height: 120,
                            decoration: BoxDecoration(
                                color: Color(0xffFEF6F4),
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 6,
                                  ),
                                  child: Icon(Icons.directions_run,
                                      color: Color(0xffF57F7B), size: 26),
                                ),
                                Text(
                                  '跑步FM',
                                  style: TextStyle(
                                      color: Color(0xffF57F7B), fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 18, bottom: 10),
                      child: Row(children: [
                        Expanded(flex: 1, child: Text('最近播放')),
                        Text('更多',
                            style: TextStyle(
                                color: Color(0xffA1A1A1), fontSize: 12)),
                        Icon(
                          Icons.chevron_right,
                          color: Color(0xffA1A1A1),
                          size: 30,
                        )
                      ]),
                    ),
                    Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Row(children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Image(
                                    image: AssetImage(
                                      "lib/assets/images/logo.jpg",
                                    ),
                                    width: 48,
                                    height: 48,
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '全部已播歌曲',
                                      style: TextStyle(
                                          color: Color(0xff595959),
                                          fontSize: 12),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text('116首',
                                          style: TextStyle(
                                              color: Color(0xffA5A5A5),
                                              fontSize: 10)),
                                    )
                                  ],
                                )
                              ])),
                          Expanded(
                              flex: 1,
                              child: Row(children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8),
                                  child: Image(
                                    image: AssetImage(
                                      "lib/assets/images/logo.jpg",
                                    ),
                                    width: 48,
                                    height: 48,
                                  ),
                                ),
                                Container(
                                    width: 100,
                                    child: Text(
                                      '视频：哈哈哈哈哈哈哈哈哈哈（Vocal：妖扬、黄因）',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Color(0xff595959),
                                          fontSize: 12),
                                    ))
                              ]))
                        ]),
                    Padding(
                        padding: EdgeInsets.only(top: 18, bottom: 10),
                        child: Row(children: [
                          Expanded(
                              flex: 1,
                              child: Row(children: [
                                Text('创建歌单(${home['songlist'].length - 1})'),
                                Padding(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    '收藏歌单(0)',
                                    style: TextStyle(color: Color(0xffA1A1A1)),
                                  ),
                                ),
                              ])),
                          Padding(
                            padding: EdgeInsets.only(right: 4, bottom: 2),
                            child: Text('+',
                                style: TextStyle(
                                    color: Color(0xffA1A1A1), fontSize: 20)),
                          ),
                          Icon(
                            Icons.more_vert,
                            color: Color(0xffA1A1A1),
                            size: 18,
                          )
                        ])),

                    // )
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 100),
                child: Column(children: collectWifget),
              )
              // Column(children: collectWifget)
            ])));
      },
    );
  }
}
