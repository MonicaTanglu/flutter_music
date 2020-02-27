import 'package:flutter/material.dart';
import 'package:weui/weui.dart';
import 'package:flutter_music/util/request.dart';

class HomeSwiper extends StatefulWidget {
  @override
  HomeSwiperState createState() => HomeSwiperState();
}

class HomeSwiperState extends State {
  var banners = [];
  getBanner(BuildContext context) async {
    try {
      await DioUtil.getInstance().get('/banner', {'type': 2}, (data) {
        setState(() {
          banners = data['banners'];
        });
      }, (err) {
        WeToast.fail(context)(message: err['message']);
      });
    } catch (e) {
      WeToast.fail(context)(message: '未知错误');
      print(e);
    }
  }

  Widget itemBuilder(int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image(
          fit: BoxFit.fill,
          image: NetworkImage(banners[index]['pic']),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getBanner(context);
  }

  @override
  Widget build(BuildContext context) {
    return banners.length > 0
        ? new WeSwipe(
            autoPlay: true,
            height: 130,
            itemCount: banners.length,
            itemBuilder: itemBuilder)
        : new Container(
            height: 130,
            child: new WeSpin(isShow: true, tip: Text('加载中...')),
          );
  }
}
