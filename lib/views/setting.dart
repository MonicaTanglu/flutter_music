import 'package:flutter/material.dart';
import 'package:flutter_music/util/theme.dart';
import 'package:flutter_music/components/box.dart';
import 'package:flutter_music/components/content.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPage createState() => new _SettingPage();
}

class _SettingPage extends State {
  bool _switchValue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('设置'),
          elevation: 0,
        ),
        backgroundColor: Color(0xffF7F7F7),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            margin: EdgeInsets.only(top: 4),
            padding: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  child: Text('网络',
                      style: TextStyle(
                          color: MyColor.lightFont,
                          fontSize: MyFontSize.smallSize)),
                  padding: EdgeInsets.only(bottom: 2),
                ),
                Flex(direction: Axis.horizontal, children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Text(
                            '使用2G/3G/4G网络播放',
                            style: TextStyle(color: MyColor.deepFont),
                          ),
                        ),
                        Text(
                          '视频Mlog播放不受此设置影响',
                          style: TextStyle(
                              color: MyColor.lightFont,
                              fontSize: MyFontSize.smallerSize),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                  Switch(
                    value: _switchValue,
                    onChanged: (v) {
                      setState(() {
                        _switchValue = v;
                      });
                    },
                  )
                ]),
                border,
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        '使用2G/3G/4G网络下载',
                        style: TextStyle(color: MyColor.deepFont),
                      ),
                    ),
                    Switch(
                      value: _switchValue,
                      onChanged: (v) {
                        setState(() {
                          _switchValue = v;
                        });
                      },
                    )
                  ],
                ),
                border,
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        '动态页中Wi-Fi下自动播放视频',
                        style: TextStyle(color: MyColor.deepFont),
                      ),
                    ),
                    Switch(
                      value: _switchValue,
                      onChanged: (v) {
                        setState(() {
                          _switchValue = v;
                        });
                      },
                    )
                  ],
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        '视频页中Wi-Fi下连续播放',
                        style: TextStyle(color: MyColor.deepFont),
                      ),
                    ),
                    Switch(
                      value: _switchValue,
                      onChanged: (v) {
                        setState(() {
                          _switchValue = v;
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 6),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  child: Text('播放和下载',
                      style: TextStyle(
                          color: MyColor.lightFont,
                          fontSize: MyFontSize.smallSize)),
                  padding: EdgeInsets.only(bottom: 2),
                ),
                Content(
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          '在线播放音质',
                          style: TextStyle(color: MyColor.deepFont),
                        ),
                      ),
                      Text(
                        '自动',
                        style: TextStyle(
                            color: MyColor.lightFont,
                            fontSize: MyFontSize.smallerSize),
                      )
                    ],
                  ),
                ),
                border,
                Content(
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          '下载音质',
                          style: TextStyle(color: MyColor.deepFont),
                        ),
                      ),
                      Text(
                        '极高',
                        style: TextStyle(
                            color: MyColor.lightFont,
                            fontSize: MyFontSize.smallerSize),
                      )
                    ],
                  ),
                ),
                border,
                Content(
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          '鲸云音效',
                          style: TextStyle(color: MyColor.deepFont),
                        ),
                      ),
                      Text(' ')
                    ],
                  ),
                ),
                border,
                Content(
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          '视频解码模式',
                          style: TextStyle(color: MyColor.deepFont),
                        ),
                      ),
                      Text(
                        '默认设置',
                        style: TextStyle(
                            color: MyColor.lightFont,
                            fontSize: MyFontSize.smallerSize),
                      )
                    ],
                  ),
                ),
                border,
                Content(
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          '视频后台播放',
                          style: TextStyle(color: MyColor.deepFont),
                        ),
                      ),
                      Switch(
                        value: _switchValue,
                        onChanged: (v) {
                          setState(() {
                            _switchValue = v;
                          });
                        },
                      )
                    ],
                  ),
                ),
                border,
                Content(
                  child: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          '边听边存',
                          style: TextStyle(color: MyColor.deepFont),
                        ),
                      ),
                      Text(
                        '未开启',
                        style: TextStyle(
                            color: MyColor.lightFont,
                            fontSize: MyFontSize.smallerSize),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 14),
            width: double.maxFinite,
            height: 44,
            color: Colors.white,
            alignment: Alignment.center,
            child: Text(
              '切换账号',
              style: TextStyle(color: MyColor.dangerColor),
            ),
          )
        ])));
  }
}
