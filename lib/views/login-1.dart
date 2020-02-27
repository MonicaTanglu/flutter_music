import 'package:flutter/material.dart';
import 'package:flutter_music/util/myIcon.dart';
import 'package:weui/weui.dart';

class LoginOne extends StatefulWidget {
  @override
  LoginOnePage createState() => new LoginOnePage();
}

class LoginOnePage extends State {
  bool _checkboxSelected = false;
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            body: Container(
      padding: EdgeInsets.all(40),
      width: double.infinity,
      color: Color(0xffDF3222),
      height: double.maxFinite,
      alignment: Alignment.topLeft,
      // height: double.infinity,
      child: Stack(
        children: <Widget>[
          Container(
              height: 80,
              margin: EdgeInsets.only(top: 60),
              alignment: Alignment.center,
              child: new ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image(
                  image: AssetImage("lib/assets/images/logo.jpg"),
                  fit: BoxFit.contain,
                  width: 80,
                  height: 80,
                ),
              )),
          Container(
            height: double.maxFinite,
            child: null,
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 2, bottom: 4, left: 10, right: 10),
                        child: Text('上次登录',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: WeButton(
                      Text('手机号登录',
                          style: new TextStyle(
                              color: Color(0xffDF3222), fontSize: 16)),
                      onClick: () {
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 42,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: WeButton(
                      Text(
                        '立即体验',
                        style: TextStyle(color: Colors.white),
                      ),
                      hollow: true,
                      theme: WeButtonType.warn,
                    )),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 34,
                                height: 34,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 0.5),
                                      borderRadius: BorderRadius.circular(17)),
                                  child: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Icon(
                                      MyIcons.weChat,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ))),
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 34,
                                height: 34,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 0.5),
                                      borderRadius: BorderRadius.circular(17)),
                                  child: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Icon(
                                      MyIcons.qq,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ))),
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 34,
                                height: 34,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 0.5),
                                      borderRadius: BorderRadius.circular(17)),
                                  child: Padding(
                                    padding: EdgeInsets.all(0),
                                    child: Icon(
                                      MyIcons.weibo,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ))),
                      Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.center,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white, width: 0.5),
                                  borderRadius: BorderRadius.circular(17)),
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text('易',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ))),
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: SizedBox(
                            height: 12,
                            width: 12,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                      color: Color(0xFFF06C5F), width: 1)),
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Text.rich(TextSpan(children: [
                            TextSpan(
                                text: '同意',
                                style: TextStyle(
                                    color: Color(0xFFF06C5F), fontSize: 10)),
                            TextSpan(
                                text: '《用户协议》《隐私政策》《儿童隐私政策》',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10))
                          ])),
                          onTap: () {
                            Navigator.pushNamed(context, '/agreement');
                          },
                        )
                      ]),
                )
              ],
            ),
          )
        ],
      ),
    )));
  }
}
