import 'package:flutter/material.dart';
import 'package:flutter_music/server/api.dart';
import 'package:flutter_music/util/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_music/components/rank_block.dart';
import 'package:flutter_music/components/loading_dialog.dart';

class RankPage extends StatefulWidget {
  @override
  _RankPage createState() => new _RankPage();
}

class _RankPage extends State with AutomaticKeepAliveClientMixin {
  List rankList = [];
  List rankBlockList = [];
  bool isLoading = true;
  TextStyle titleStyle =
      TextStyle(fontWeight: FontWeight.w600, fontSize: MyFontSize.comSize);
  double width;
  TextStyle style =
      TextStyle(color: Color(0xff989898), fontSize: MyFontSize.midSize);
  SharedPreferences prefs;

  getRankList() async {
    setState(() {
      isLoading = true;
    });
    Api.getTopListDetail(null, (data) {
      if (data['code'] == 200) {
        // rankList = data['list'];
        for (int i = 0; i < data['list'].length; i++) {
          if (data['list'][i]['tracks'].length >= 3) {
            rankList.add(data['list'][i]);
          } else {
            rankBlockList.add(data['list'][i]);
          }
        }
      }
      setState(() {
        isLoading = false;
      });
    });
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    getRankList();
  }

  List<Widget> itemBuild() {
    List<Widget> children = [];
    int length = rankList.length > 5 ? 6 : rankList.length;
    for (int i = 0; i < length; i++) {
      children.add(InkWell(
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('songSheetId', rankList[i]['id'].toString());
            Navigator.pushNamed(context, '/songlist');
          },
          child: Container(
            padding: EdgeInsets.only(bottom: 6),
            height: 96,
            child: Row(children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        rankList[i]['coverImgUrl'],
                        width: 90,
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 4, bottom: 6),
                    child: Text(
                      rankList[i]['updateFrequency'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MyFontSize.smallerSize),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 6),
              ),
              Expanded(
                flex: 1,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Text('加油')
                      Text(
                          "1.${rankList[i]['tracks'][0]['first']} - ${rankList[i]['tracks'][0]['second']}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: style),
                      Text(
                          '2.${rankList[i]['tracks'][1]['first']} - ${rankList[i]['tracks'][1]['second']}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: style),
                      Text(
                          '3.${rankList[i]['tracks'][2]['first']} - ${rankList[i]['tracks'][2]['second']}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: style),
                    ]),
              )
            ]),
          )));
    }
    return children;
  }

  Widget buildRank(int start, int length) {
    int rows = length ~/ 3;
    List<Widget> rowChildren = [];

    if (length % 3 != 0) rows++;
    for (int row = 0; row < rows; row++) {
      int i = 3 * row + start;
      print(i);
      int total = start + length;
      Widget rowWidget = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   width: width,
          Container(
            width: width,
            margin: EdgeInsets.only(right: 6, bottom: 16),
            child: GestureDetector(
                onTap: () {
                  prefs.setString(
                      'songSheetId', rankBlockList[i]['id'].toString());
                  Navigator.pushNamed(context, '/songlist');
                },
                child: RankBlock(rankBlockList[i])),
          ),
          // ),
          // ),

          Container(
              width: width,
              margin: EdgeInsets.only(right: 3, bottom: 16, left: 3),
              child: (i + 1) < total
                  ? GestureDetector(
                      onTap: () {
                        prefs.setString('songSheetId',
                            rankBlockList[i + 1]['id'].toString());
                        Navigator.pushNamed(context, '/songlist');
                      },
                      child: RankBlock(rankBlockList[i + 1]),
                    )
                  : null),
          // ),
          Container(
              width: width,
              margin: EdgeInsets.only(bottom: 16, left: 6),
              child: (i + 2) < total
                  ? GestureDetector(
                      onTap: () {
                        prefs.setString('songSheetId',
                            rankBlockList[i + 2]['id'].toString());
                        Navigator.pushNamed(context, '/songlist');
                      },
                      child: RankBlock(rankBlockList[i + 2]),
                    )
                  : null),
          // )
        ],
      );
      // start =
      rowChildren.add(rowWidget);
    }
    return Column(children: rowChildren);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    width = (MediaQuery.of(context).size.width - 50) / 3;
    print(width);
    print('I am tanglu');
    return Scaffold(
        appBar: AppBar(
          title: Text('排行榜'),
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: isLoading == false
                ? Container(
                    color: Colors.white,
                    // width: double.infinity,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('官方榜', style: titleStyle),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                        ),
                        Column(children: itemBuild()),
                        Container(
                          height: 30,
                          child: null,
                        ),
                        Text('推荐榜'),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                        ),
                        buildRank(0, 6),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                        ),
                        Text('全球榜'),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                        ),
                        buildRank(6, 6),
                        Container(
                          height: 30,
                          child: null,
                        ),
                        Text('更多榜单'),
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                        ),
                        buildRank(12, rankBlockList.length - 12),
                      ],
                    ),
                  )
                : LoadingDialog()
            // : showDialog(
            //     context: context,
            //     barrierDismissible: false,
            //     builder: (BuildContext context) {
            //       return LoadingDialog(text: '加载中...');
            //     })
            ));
  }

  @override
  bool get wantKeepAlive => true;
}
