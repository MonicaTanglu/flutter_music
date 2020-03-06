import 'package:flutter/material.dart';
import 'package:weui/weui.dart';
import 'package:flutter_music/layout/sample.dart';
import 'package:flutter_music/components/box.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => new LoginPageState();
}

class LoginPageState extends State {
  String username = '';
  String password = '';
  bool _isLoading = false;
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Sample(
        '手机号登录',
        describe: '未注册手机号登录后将自动创建账号',
        showPadding: false,
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 8, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.phone,
                controller: _phoneController,
                autofocus: true,
                style: TextStyle(color: Color(0xff333333)),
                decoration: InputDecoration(
                    hintText: '请输入手机号码',
                    prefixText: '+86  ',
                    contentPadding: EdgeInsets.only(top: 16, bottom: 6),
                    suffixIcon: GestureDetector(
                      child: Icon(
                        Icons.clear,
                        color: Color(0xffC3C3C3),
                        size: 14,
                      ),
                      onTap: () {
                        _phoneController.text = '';
                      },
                    ),
                    prefixStyle: TextStyle(color: Color(0xff333333)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffEAEAEA), width: 1)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffEAEAEA), width: 1))),
              ),
              box,
              box,
              Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: <Widget>[
                    box,
                    box,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: WeButton('下一步',
                          theme: WeButtonType.warn,
                          loading: _isLoading, onClick: () {
                        print(_phoneController.text);
                        if (_phoneController.text == '') {
                          WeToast.info(context)('请输入手机号');
                          return;
                        }
                        Navigator.pushNamed(context, '/twoLogin',
                            arguments: {'phoneNumber': _phoneController.text});
                      }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
