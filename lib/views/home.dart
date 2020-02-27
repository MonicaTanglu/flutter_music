import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_music/components/box.dart';
import 'package:weui/weui.dart';

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
    print(prefs);
    print('homehome');
    if (userId != null) {
      setState(() {
        userInfo['avatarUrl'] = prefs.get('avatarUrl');
        userInfo['nickname'] = prefs.get('nickname');
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    loginState(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
                              image: NetworkImage(userInfo['avatarUrl']),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text(userInfo['nickname'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    color: Color(0xff605F64),
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
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
                        style:
                            TextStyle(color: Color(0xff7B7B80), fontSize: 10),
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
                          Icon(Icons.fiber_new, color: Colors.white, size: 28),
                          box,
                          Text('关注新歌', style: fontStyle)
                        ]),
                      )
                    ],
                  ),
                )
              ])),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 120, left: 16, right: 16),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
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
                        style:
                            TextStyle(color: Color(0xffA1A1A1), fontSize: 12)),
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
                                      color: Color(0xff595959), fontSize: 12),
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
                                  '视频：香水有毒（Vocal：妖扬、黄因）',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Color(0xff595959), fontSize: 12),
                                ))
                          ]))
                    ]),
                Padding(
                  padding: EdgeInsets.only(top: 18, bottom: 10),
                  child: Row(children: [
                    Expanded(
                        flex: 1,
                        child: Row(children: [
                          Text('创建歌单(2)'),
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
                                  '英文',
                                  style: TextStyle(
                                      color: Color(0xff595959), fontSize: 12),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text('186首',
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'one',
                                      style: TextStyle(
                                          color: Color(0xff595959),
                                          fontSize: 12),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text('10首',
                                          style: TextStyle(
                                              color: Color(0xffA5A5A5),
                                              fontSize: 10)),
                                    )
                                  ],
                                ))
                          ]))
                    ]),
              ],
            ),
          )
        ])));
  }
}
