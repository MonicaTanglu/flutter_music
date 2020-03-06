import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_music/util/theme.dart';
import 'package:flutter_music/components/box.dart';

class MinePage extends StatefulWidget {
  _MinePage createState() => new _MinePage();
}

class _MinePage extends State with SingleTickerProviderStateMixin {
  var userInfo = {};

  loginState(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userInfo['avatarUrl'] = prefs.get('avatarUrl');
      userInfo['nickname'] = prefs.get('nickname');
    });
  }

  @override
  void initState() {
    super.initState();
    loginState(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          // Column(children: [
          Container(
        height: double.maxFinite,
        // decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(20),
        //         topRight: Radius.circular(20))),
        child: Stack(
          children: <Widget>[
            Container(
                width: double.maxFinite,
                height: 280,
                decoration: BoxDecoration(
                    // color: Colors.black,
                    image: DecorationImage(
                        image: ExactAssetImage("lib/assets/images/bg.jpg"),
                        fit: BoxFit.cover,
                        repeat: ImageRepeat.noRepeat)),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 36, left: 16, right: 16, bottom: 10),
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          child: Icon(
                              Theme.of(context).platform ==
                                      TargetPlatform.android
                                  ? Icons.arrow_back
                                  : Icons.arrow_back_ios,
                              color: Colors.white),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        GestureDetector(
                          child: Icon(Icons.share, color: Colors.white),
                          onTap: () {
                            print('share');
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 30, left: 20, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 10),
                            child: new ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(userInfo['avatarUrl'],
                                    height: 60.0,
                                    width: 60.0,
                                    fit: BoxFit.fill)),
                          ),
                          Text(
                            userInfo['nickname'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: MyFontSize.comSize,
                                fontWeight: FontWeight.w500),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 6, bottom: 4),
                            child: Text(
                              '关注 3 | 粉丝 0',
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 0.8),
                                  fontSize: MyFontSize.smallSize,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                new ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          top: 2, left: 10, right: 10),
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      child: Text('lv.5',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontStyle: FontStyle.italic,
                                              fontSize:
                                                  MyFontSize.smallerSize))),
                                ),
                                Row(
                                  children: <Widget>[
                                    new ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 8,
                                              bottom: 8,
                                              left: 12,
                                              right: 18),
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.5),
                                          child: GestureDetector(
                                            child: Text('编辑',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: MyFontSize
                                                        .smallerSize)),
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/person');
                                            },
                                          ),
                                        )),
                                    SizedBox(
                                      width: 6,
                                      child: null,
                                    ),
                                    new ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: 8,
                                              bottom: 8,
                                              left: 12,
                                              right: 18),
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.5),
                                          child: Text('更换背景',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      MyFontSize.smallerSize)),
                                        )),
                                  ],
                                )
                              ])
                        ],
                      ))
                ])),
            new Positioned(
                top: 250,
                left: 0,
                right: 0,
                // height: 500,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: MyColor.dangerColor, width: 2))),
                            child: Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 8),
                              child: Text(
                                '主页',
                                style: TextStyle(color: MyColor.dangerColor),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: Text('动态'),
                          )
                        ],
                      ),
                      border,
                      // SingleChildScrollView(child: ,)
                      Container(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 16, bottom: 40),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '听歌排行',
                                          style: TextStyle(
                                              color: Color(0xff595959),
                                              fontSize: 12),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Text('累计听歌338首',
                                              style: TextStyle(
                                                  color: MyColor.lightFont,
                                                  fontSize:
                                                      MyFontSize.smallerSize)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 6,
                                  child: null,
                                ),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '我喜欢的音乐',
                                          style: TextStyle(
                                              color: Color(0xff595959),
                                              fontSize: 12),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Text('0首，播放0次',
                                              style: TextStyle(
                                                  color: MyColor.lightFont,
                                                  fontSize:
                                                      MyFontSize.smallerSize)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                box,
                                box,
                                box,
                                Row(
                                  children: <Widget>[
                                    Text('创建的歌单',
                                        style: TextStyle(
                                            fontSize: MyFontSize.comSize,
                                            fontWeight: FontWeight.w500)),
                                    Text('（2个，被收藏0次）',
                                        style: TextStyle(
                                            fontSize: MyFontSize.smallerSize,
                                            color: MyColor.lightFont))
                                  ],
                                ),
                                box,
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '英文',
                                          style: TextStyle(
                                              color: Color(0xff595959),
                                              fontSize: 12),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Text('186首，播放13次',
                                              style: TextStyle(
                                                  color: MyColor.lightFont,
                                                  fontSize:
                                                      MyFontSize.smallerSize)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                box_6,
                                Flex(
                                  direction: Axis.horizontal,
                                  children: [
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'one',
                                          style: TextStyle(
                                              color: Color(0xff595959),
                                              fontSize: 12),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: Text('10首，播放47次',
                                              style: TextStyle(
                                                  color: MyColor.lightFont,
                                                  fontSize:
                                                      MyFontSize.smallerSize)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                box,
                                box,
                                box,
                                Row(
                                  children: <Widget>[
                                    Text('创建的歌单',
                                        style: TextStyle(
                                            fontSize: MyFontSize.comSize,
                                            fontWeight: FontWeight.w500)),
                                    Text('(部分信息展示可在隐私设置中修改)',
                                        style: TextStyle(
                                            fontSize: MyFontSize.smallerSize,
                                            color: MyColor.lightFont))
                                  ],
                                ),
                                box_6,
                                Text('村龄：1年(2018年7月注册)',
                                    style: TextStyle(
                                        fontSize: MyFontSize.smallerSize,
                                        color: MyColor.lightFont)),
                                box_6,
                                Text('地区：江西省 南昌市',
                                    style: TextStyle(
                                        fontSize: MyFontSize.smallerSize,
                                        color: MyColor.lightFont)),
                                Container(
                                  height: 40,
                                  child: null,
                                )
                              ])),
                    ])))),
          ],
        ),
      ),
      // ])
    );
  }
}
