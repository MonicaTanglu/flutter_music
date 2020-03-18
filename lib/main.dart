import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_music/redux/index.dart';
// import 'package:flutter_music/views/find.dart';
import 'package:flutter_music/views/login.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_music/router/index.dart';
import 'package:flutter_music/views/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:weui/weui.dart';
import 'package:flutter_music/components/toast.dart';
// import 'package:flutter_music/views/login-1.dart';

// void main() => runApp(MyApp());

// 初始化应用状态
final store = Store<PlayState>(reducer, initialState: PlayState.initState());
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp(store));
  }); // 强制竖屏
  // 若强制横屏则改参数（DeviceOrientation.portraitLeft,DeviceOrientation.portraitRight）
}

class MyApp extends StatefulWidget {
  final Store<PlayState> store;
  MyApp(this.store);
  @override
  AppState createState() => AppState();
  // This widget is the root of your application.
}

class AppState extends State {
  bool isDefaultTheme = true;
  String userId = '';
  DateTime lastPopTime;

  void toggleTheme() {
    this.setState(() {
      isDefaultTheme = !isDefaultTheme;
    });
  }

  @override
  void initState() {
    super.initState();
    loginState(context);
  }

  loginState(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString("userId");
    });
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<PlayState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // onGenerateRoute: (RouteSettings settings) { // 路由拦截
        // },
        routes: routes,
        theme:
            new ThemeData(primaryColor: Colors.white, accentColor: Colors.red),
        home: WillPopScope(
            onWillPop: () async {
              if (lastPopTime == null ||
                  DateTime.now().difference(lastPopTime) >
                      Duration(seconds: 2)) {
                lastPopTime = DateTime.now();
                // 这里弹窗禁止退出
                // Toast.toast(context,
                //     msg: '再按一次退出~', showTime: 3000, position: 'top');
                return new Future.value(false);
              } else {
                lastPopTime = DateTime.now();
                // await SystemChannels.platform
                //     .invokeMethod('SystemNavigator.pop');
                return new Future.value(true);
              }
            },
            child: userId == '' || userId == null ? LoginPage() : IndexPage()),
      ),
    );
  }
}
