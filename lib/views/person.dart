import 'package:flutter/material.dart';
import 'package:flutter_music/components/box.dart';
import 'package:flutter_music/components/content.dart';
import 'package:flutter_music/util/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PersonPage extends StatefulWidget {
  @override
  _PersonPage createState() => _PersonPage();
}

class _PersonPage extends State {
  var userInfo = {};
  var userId;
  File _image;

  loginState(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.get('userId');
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
    return new Scaffold(
      backgroundColor: MyColor.backColor,
      appBar: AppBar(
        title: Text('我的资料'),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 6),
        child: ListView(children: [
          Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Column(children: [
                Content(
                    child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('头像'),
                    GestureDetector(
                        onTap: () async {
                          var image = await ImagePicker.pickImage(
                              source: ImageSource.gallery);
                          setState(() {
                            _image = image;
                          });
                        },
                        child: new ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: _image != null
                                ? Image.file(
                                    _image,
                                    width: 36,
                                    height: 36,
                                  )
                                : Image.network(userInfo['avatarUrl'],
                                    height: 36.0,
                                    width: 36.0,
                                    fit: BoxFit.fill)))
                  ],
                )),
                border,
                Content(
                    child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('昵称'),
                    Text(
                      userInfo['nickname'],
                      style: TextStyle(
                          color: MyColor.lightFont,
                          fontSize: MyFontSize.smallSize),
                    )
                  ],
                )),
                border,
                Content(
                    child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('性别'),
                    // Text(
                    //   userInfo['nickname'],
                    //   style: TextStyle(
                    //       color: MyColor.lightFont,
                    //       fontSize: MyFontSize.smallSize),
                    // )
                  ],
                )),
                border,
                Content(
                    child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('二维码'),
                  ],
                )),
              ])),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 16, right: 16),
            margin: EdgeInsets.only(top: 6),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Content(
                  child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('生日'),
                  Text(
                    '未设置',
                    style: TextStyle(
                        color: MyColor.lightFont,
                        fontSize: MyFontSize.smallSize),
                  )
                ],
              )),
              border,
              Content(
                  child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('地区'),
                  Text(
                    '江西省 南昌市',
                    style: TextStyle(
                        color: MyColor.lightFont,
                        fontSize: MyFontSize.smallSize),
                  )
                ],
              )),
              border,
              Content(
                  child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('大学'),
                  Text(
                    '未填写',
                    style: TextStyle(
                        color: MyColor.lightFont,
                        fontSize: MyFontSize.smallSize),
                  )
                ],
              )),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 14),
                child: Text(
                  '此三项可以在“设置”页中设为隐私',
                  style: TextStyle(
                      color: MyColor.lightFont,
                      fontSize: MyFontSize.smallerSize),
                ),
              )
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 6),
            padding: EdgeInsets.only(left: 16, right: 16),
            color: Colors.white,
            child: Content(
                child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('签名'),
                Text(
                  '还没有签名',
                  style: TextStyle(
                      color: MyColor.lightFont, fontSize: MyFontSize.smallSize),
                )
              ],
            )),
          ),
          Container(
              margin: EdgeInsets.only(top: 6),
              padding: EdgeInsets.only(left: 16, right: 16),
              color: Colors.white,
              // height: double.maxFinite,
              child: Column(children: [
                Content(
                    child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text('账号和绑定设置')],
                )),
                border,
                Content(
                    child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[Text('个人主页展示设置')],
                )),
              ]))
        ]),
        // ),
      ),
    );
  }
}
