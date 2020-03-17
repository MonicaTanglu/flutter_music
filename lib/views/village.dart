import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/components/loading_dialog.dart';
import 'package:flutter_music/util/theme.dart';
import 'package:flutter_music/server/api.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class VillagePage extends StatefulWidget {
  _VillagePage createState() => _VillagePage();
}

class _VillagePage extends State
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  ScrollController _controller = ScrollController();
  DateTime time = DateTime.now();
  double width2 = 120;
  int limit = 16;
  int total = 16;
  int pageNow = 1;
  int lasttime = -1;
  List list = [];
  bool _isLoading = true;
  bool isNoMoreData = false;
  List<Widget> children = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getPlayList();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent &&
          !_isLoading &&
          this.isNoMoreData) {
        // pageNow++;
        getPlayList();
      }
    });
  }

  @override
  bool get wantKeepAlive => true;

  String getUpperMonth(int month) {
    String monthStr = 'Jan';
    switch (month) {
      case 1:
        monthStr = 'Jan';
        break;
      case 2:
        monthStr = 'Feb';
        break;
      case 3:
        monthStr = 'Mar';
        break;
      case 4:
        monthStr = 'Apr';
        break;
      case 5:
        monthStr = 'May';
        break;
      case 6:
        monthStr = 'Jun';
        break;
      case 7:
        monthStr = 'Jul';
        break;
      case 8:
        monthStr = 'Aug';
        break;
      case 9:
        monthStr = 'Sept';
        break;
      case 10:
        monthStr = 'Oct';
        break;
      case 11:
        monthStr = 'Nov';
        break;
      case 12:
        monthStr = 'Dec';
        break;
      default:
        break;
    }
    return monthStr;
  }

  getPlayList() {
    setState(() {
      _isLoading = true;
    });
    Api.getTopPlayList({'pagesize': limit, 'lasttime': lasttime}, (data) {
      if (data['code'] == 200) {
        setState(() {
          list.addAll(data['event']);
          lasttime = data['lasttime'];
          isNoMoreData = data['more'];
        });
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  getWrapWidgets(int i) {
    Map<String, dynamic> jsonList = jsonDecode(list[i]['json']);

    Widget child = Container(
      width: width2,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              imageUrl: list[i]['pics'].length > 0
                  ? list[i]['pics'][0]['squareUrl']
                  : 'https://p1.music.126.net/tkdsPjCEurW-Zj6Mey_LeA==/109951164780845597.jpg',
              width: width2,
              placeholder: (context, url) => CircularProgressIndicator(),
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.all(8),
            child: Text(
              jsonList['msg'] == null ? '出错了' : jsonList['msg'],
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            )),
        Padding(
          padding: EdgeInsets.only(bottom: 10, top: 0, left: 8, right: 8),
          child: Row(children: [
            Expanded(
              child: Row(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: list[i]['user']['avatarUrl'] != null
                      ? Image.network(
                          list[i]['user']['avatarUrl'],
                          width: 16,
                          height: 16,
                        )
                      : null,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Text(
                    list[i]['user']['nickname'],
                    style: TextStyle(
                        color: MyColor.lightFont,
                        fontSize: MyFontSize.smallSize),
                  ),
                )
              ]),
            ),
            Text("${list[i]['info']['commentThread']['likedCount']}赞",
                style: TextStyle(
                    color: MyColor.lightFont, fontSize: MyFontSize.smallSize))
          ]),
        )
      ]),
    );
    return child;
  }

  @override
  Widget build(BuildContext context) {
    // print('x');
    super.build(context);
    width2 = (MediaQuery.of(context).size.width - 40) / 2;
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
          title: TabBar(
            // indicator: BoxDecoration(),
            indicatorWeight: 2,
            indicatorPadding: EdgeInsets.only(top: 4),
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: MyColor.commonFont,
            controller: _tabController,
            labelStyle: TextStyle(),
            // labelPadding: EdgeInsets.only(bottom: 0, right: 24),
            tabs: <Widget>[
              Tab(
                  child: Container(
                padding: EdgeInsets.only(top: 4, left: 6, right: 6),
                child: Text('广场'),
              )),
              Tab(
                child: Padding(
                    child: Text('关注'),
                    padding: EdgeInsets.only(top: 4, left: 6, right: 6)),
              )
            ],
          ),
        ),
        preferredSize: Size.fromHeight(40),
      ),
      body: list.length == 0 && _isLoading
          ? LoadingDialog(text: '加载中...')
          // showDialog(
          //     context: context,
          //     barrierDismissible: false,
          //     builder: (BuildContext context) {
          //       return LoadingDialog(text: '加载中...');
          //     })
          : TabBarView(
              controller: _tabController,
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(top: 8, bottom: 16, right: 16, left: 16),
                  child: ListView(
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    // controller: _controller,
                    controller: _controller,
                    // primary: false,
                    children: <Widget>[
                      Container(
                        // height: 80,
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: LinearGradient(
                                colors: [Color(0xff94A19C), Color(0xff949494)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight)),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Column(children: [
                                Row(children: [
                                  Text(
                                    '云村热评墙',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: MyFontSize.comSize),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 17,
                                  )
                                ]),
                                Padding(
                                  padding: EdgeInsets.only(top: 8),
                                ),
                                Text(
                                  '一个人最好的生活状态，是该看书时看书，该玩时尽情玩',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: MyFontSize.smallSize),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ]),
                            ),
                            Column(children: [
                              Text(
                                getUpperMonth(time.month) + '.',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(time.day.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600))
                            ])
                          ],
                        ),
                      ),
                      StaggeredGridView.countBuilder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          // controller: _controller,
                          primary: false,
                          crossAxisCount: 4,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          itemBuilder: (context, index) =>
                              getWrapWidgets(index),
                          itemCount: list.length,
                          staggeredTileBuilder: (index) =>
                              StaggeredTile.fit(2)),
                      // ),
                      // Wrap(
                      //   direction: Axis.horizontal,
                      //   runSpacing: 0,
                      //   alignment: WrapAlignment.start,
                      //   children: getWrapWidgets(),
                      // )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text('云村关注'),
                )
              ],
            ),
    );
  }
}
