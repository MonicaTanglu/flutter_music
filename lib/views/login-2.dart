import 'package:flutter/material.dart';
import 'package:weui/weui.dart';
import 'package:flutter_music/components/box.dart';
import 'package:flutter_music/layout/sample.dart';
import 'package:flutter_music/util/request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_music/server/common.dart';

class LoginTwo extends StatefulWidget {
  @override
  LoginTwoPage createState() => new LoginTwoPage();
}

class LoginTwoPage extends State {
  // LoginTwo({this.phoneNumber});
  var _phoneNumber;
  var password;
  var args;
  var _isLoading = false;
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    _phoneNumber = args['phoneNumber'];
    print(args);
    return new Scaffold(
      body: Sample(
        '手机号登录',
        describe: '',
        showPadding: false,
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 8, left: 20, right: 20),
          child: Column(
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: _passwordController,
                autofocus: true,
                style: TextStyle(color: Color(0xff333333)),
                decoration: InputDecoration(
                    hintText: '请输入密码',
                    contentPadding: EdgeInsets.only(top: 16, bottom: 6),
                    suffixIcon: GestureDetector(
                      child: Icon(
                        Icons.clear,
                        color: Color(0xffC3C3C3),
                        size: 14,
                      ),
                      onTap: () {
                        _passwordController.text = '';
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
                      child: WeButton('登录',
                          theme: WeButtonType.warn,
                          loading: _isLoading, onClick: () async {
                        if (_passwordController.text == '') {
                          WeToast.info(context)('请输入密码');
                          return;
                        }
                        password = _passwordController.text;
                        setState(() {
                          _isLoading = true;
                        });
                        final response = await DioUtil.getInstance().post(
                            "/login/cellphone?phone=$_phoneNumber&password=$password",
                            {'username': _phoneNumber, 'password': password});
                        setState(() {
                          _isLoading = false;
                        });
                        final data = response.data;
                        print(data);
                        print('personalInfo');
                        if (data['code'] == 200) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          data['profile'].forEach((String key, value) {
                            prefs.setString(key, value.toString());
                          });
                          getSongList();
                          // 跳转到根路由
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/index', (route) => false);
                        } else {
                          WeToast.info(context)(response.data['message']);
                        }
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
