import 'package:flutter/material.dart';
import 'package:flutter_music/util/theme.dart';
import 'package:flutter_music/server/api.dart';
import 'package:flutter_music/components/box.dart';
import 'dart:convert';
import 'package:flustars/flustars.dart';

class InformationPage extends StatefulWidget {
  @override
  _InformationPage createState() => _InformationPage();
}

class _InformationPage extends State with SingleTickerProviderStateMixin {
  List msgs = [];
  int newMsgCount = 0;
  int itemCount = 0;
  TabController _tabController;
  getMsgPrivate() {
    Api.getMsgPrivate({'offset': 0}, (data) {
      if (data['code'] == 200) {
        setState(() {
          msgs = data['msgs'];
          itemCount = msgs.length;
          newMsgCount = data['newMsgCount'];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
    getMsgPrivate();
  }

  Widget itemBuilders(BuildContext context, int index) {
    Map<String, dynamic> list = jsonDecode(msgs[index]['lastMsg']);

    String date =
        DateUtil.formatDateMs(msgs[index]['lastMsgTime'], format: 'yyyy年M月d日');
    String count = msgs[index]['newMsgCount'].toString();
    return Row(
      // mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 4),
          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: Image(
              image: NetworkImage(msgs[index]['fromUser']['avatarUrl']),
              width: 46,
              height: 46,
            ),
          ),
        ),
        Expanded(
          child: Container(
            // width: double.infinity,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: MyColor.borderColor))),
            height: 60,
            padding: EdgeInsets.only(right: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text('测试')
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          msgs[index]['fromUser']['nickname'],
                          style: TextStyle(
                              color: MyColor.deepFont,
                              fontSize: MyFontSize.midSize),
                        ),
                      ),
                      Text(date,
                          style: TextStyle(
                              color: MyColor.lightFont,
                              fontSize: MyFontSize.smallerSize)),
                    ],
                  ),
                  // ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Text(
                              list['inboxBriefContent'] == null
                                  ? list['msg']
                                  : list['inboxBriefContent'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: MyColor.lightFont,
                                  fontSize: MyFontSize.smallSize),
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: 1, bottom: 1, left: 3, right: 3),
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(count,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: MyFontSize.smallerSize)),
                      )
                    ],
                  )
                ]),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('我的消息'),
          elevation: 0,
          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 16),
              alignment: Alignment.center,
              child: Text(
                '标记已读',
                style: TextStyle(fontSize: MyFontSize.midSize),
              ),
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelColor: MyColor.deepFont,
            labelColor: Theme.of(context).accentColor,
            tabs: <Widget>[
              Stack(overflow: Overflow.visible, children: [
                Tab(
                  child: Text('私信'),
                ),
                // ),
                newMsgCount == 0
                    ? Container(
                        child: null,
                      )
                    : Positioned(
                        right: -16,
                        top: 16,
                        child: Container(
                            padding: EdgeInsets.only(
                                top: 2, bottom: 1, left: 3, right: 3),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              '13',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            )),
                      ),
              ]),
              Tab(
                child: Text('评论'),
              ),
              Tab(
                child: Text('@我'),
              ),
              Tab(
                child: Text('通知'),
              )
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
                child: Column(children: <Widget>[
              border,
              // Text('速度发货就')
              Flexible(
                child: ListView.builder(
                    itemCount: itemCount, itemBuilder: itemBuilders),
              )
            ])),
            Container(
              alignment: Alignment.center,
              child: Text('评论'),
            ),
            Container(
              alignment: Alignment.center,
              child: Text('@我'),
            ),
            Container(
              alignment: Alignment.center,
              child: Text('通知'),
            ),
          ],
        ));
  }
}
