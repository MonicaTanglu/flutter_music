import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/components/loading_dialog.dart';
import 'package:flutter_music/server/api.dart';
import 'package:flutter_music/util/theme.dart';
import 'package:flutter_music/components/box.dart';
import 'package:flustars/flustars.dart';

class VideoPage extends StatefulWidget {
  _VideoPage createState() => _VideoPage();
}

//with AutomaticKeepAliveClientMixin
class _VideoPage extends State
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  // @override
  // bool get wantKeepAlive => true;
  List tags = [];
  int tagId;
  List videos = [];
  bool _loading = true;

  getTags() {
    setState(() {
      _loading = true;
    });
    Api.getVideoTags((data) {
      if (data['code'] == 200) {
        tags = data['data'].sublist(0, 10);
        if (tags.length > 0)
          getVideoList(tags[0]['id']);
        else {
          setState(() {
            _loading = false;
          });
        }
      }
    });
  }

  getVideoList(id) {
    setState(() {
      _loading = true;
    });
    Api.getVideoList({'id': id}, (data) {
      if (data['code'] == 200) {
        videos = data['datas'];
      }
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getTags();
    _tabController = new TabController(length: 10, vsync: this);
  }

  @override
  bool get wantKeepAlive => true;

  Widget itemBuilder(BuildContext context, int i) {
    Map data = videos[i]['data'];
    String time = DateUtil.formatDateMs(data['durationms'], format: 'mm:ss');
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/videoDetail',
              arguments: {'videoId': data['vid']});
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 8),
          color: Colors.white,
          padding: EdgeInsets.only(top: 8, bottom: 6, left: 16, right: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl: data['coverUrl'],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white.withOpacity(0.8),
                    size: 50,
                  ),
                ),
                Positioned(
                  bottom: 6,
                  left: 4,
                  right: 4,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          children: <Widget>[
                            Icon(
                              Icons.play_arrow,
                              color: Colors.white.withOpacity(0.8),
                              size: 14,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 2, top: 0),
                              child: Text(
                                (data['playTime'] / 1000).round().toString() +
                                    '万',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            )
                          ],
                        ),
                        Wrap(
                          children: <Widget>[
                            Icon(
                              Icons.equalizer,
                              color: Colors.white.withOpacity(0.8),
                              size: 14,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 4, top: 2),
                              child: Text(time,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            )
                          ],
                        )
                      ]),
                )
              ],
            ),
            Padding(
              child: Text(
                data['title'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: MyColor.commonFont),
              ),
              padding: EdgeInsets.only(top: 8, bottom: 8),
            ),
            border,
            Padding(
                padding: EdgeInsets.only(top: 6, bottom: 6),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              data['creator']['avatarUrl'],
                              width: 20,
                              height: 20,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Text(
                              data['creator']['nickname'],
                              style: TextStyle(
                                  color: Color(0xffACACAC), fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Icon(
                              Icons.thumb_up,
                              color: Color(0xffACACAC),
                              size: 16,
                            ),
                            Positioned(
                              top: -3,
                              left: 12,
                              child: Container(
                                  padding: EdgeInsets.only(left: 2, right: 2),
                                  color: Colors.white,
                                  child: Text(data['praisedCount'].toString(),
                                      style: TextStyle(
                                          color: Color(0xffACACAC),
                                          fontSize: 10))),
                            )
                          ],
                        )),
                    Padding(
                      padding: EdgeInsets.only(right: 16, left: 10),
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Icon(
                            Icons.message,
                            color: Color(0xffACACAC),
                            size: 16,
                          ),
                          Positioned(
                            top: -3,
                            left: 12,
                            child: Container(
                                padding: EdgeInsets.only(left: 2, right: 2),
                                color: Colors.white,
                                child: Text(data['commentCount'].toString(),
                                    style: TextStyle(
                                        color: Color(0xffACACAC),
                                        fontSize: 10))),
                          )
                        ],
                      ),
                    )
                  ],
                ))
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 2,
                    color: Color(0xfff4f4f4),
                  ),
                ),
                TabBar(
                  indicatorWeight: 3,
                  indicatorPadding: EdgeInsets.only(top: 8),
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Theme.of(context).accentColor,
                  unselectedLabelColor: MyColor.commonFont,
                  isScrollable: true,
                  controller: _tabController,
                  tabs: tags.map((obj) {
                    return Tab(
                      child: Text(
                        obj is Map ? obj['name'] : '...',
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                      ),
                    );
                  }).toList(),
                  onTap: (int index) {
                    getVideoList(tags[index]['id']);
                  },
                ),
              ],
            )),
        preferredSize: Size.fromHeight(47),
      ),
      body: videos.length == 0 && _loading
          ? LoadingDialog(text: '加载中...')
          : TabBarView(
              controller: _tabController,
              children: tags.asMap().keys.map((int i) {
                // if (i == 0) {
                return ListView.builder(
                    itemCount: videos.length, itemBuilder: itemBuilder);
                // } else {
                //   return Container(
                //     child: Text(tags[i]['name']),
                //   );
                // }
              }).toList()),
      // border
      // ],
    );
  }
}

class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin = EdgeInsets.zero;

  TestFlowDelegate({this.margin});
  @override
  void paintChildren(FlowPaintingContext context) {
    var x = margin.left;
    var y = margin.top;
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i).width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        context.paintChild(i,
            transform: new Matrix4.translationValues(x, y, 0.0));
        y += context.getChildSize(i).height + margin.top + margin.bottom;
        x += context.getChildSize(i).width + margin.left + margin.right;
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
