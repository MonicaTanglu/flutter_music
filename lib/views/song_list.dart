import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_music/components/action_song.dart';
import 'package:flutter_music/components/load_more.dart';
import 'package:flutter_music/components/play_bar.dart';
import 'package:flutter_music/server/api.dart';
import 'package:flutter_music/util/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weui/toast/index.dart';
import 'package:flutter_music/components/box.dart';
import 'dart:ui';
import 'package:flutter_music/server/common.dart';

import '../main.dart';

class SongListPage extends StatefulWidget {
  @override
  _SongListPage createState() => new _SongListPage();
}

class _SongListPage extends State with AutomaticKeepAliveClientMixin {
  List playLists = [];
  var listInfo = {};
  String title = '歌单';
  bool isLoading = false;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getPlaylist(context);
  }

  getPlaylist(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.get('songSheetId');
    Api.getPlayList({'id': id}, (data) {
      setState(() {
        isLoading = false;
      });
      if (data['code'] == 200) {
        setState(() {
          listInfo = data['playlist'];
          playLists = listInfo['tracks'];
          title = data['playlist']['name'];
        });
      } else {
        WeToast.info(context)(data['message']);
      }
    });
  }
  // @override
  // void didUpdateWidget(StatefulWidget oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  // }

/**
 * CircularProgressIndicator material design风格循环进度条，旋转表示应用程序正忙
 */
  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 16)),
              listInfo['coverImgUrl'] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: CachedNetworkImage(
                        height: 120.0,
                        width: 120.0,
                        fit: BoxFit.cover,
                        imageUrl: listInfo['coverImgUrl'],
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      width: 120.0,
                      height: 120.0,
                      color: Colors.grey,
                    ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                      box,
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: listInfo['coverImgUrl'] != null
                                  ? Image(
                                      height: 30.0,
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          listInfo['creator']['avatarUrl']),
                                    )
                                  : Text(
                                      '加载中...',
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                            Padding(padding: EdgeInsets.only(left: 10)),
                            Text(
                              listInfo['coverImgUrl'] != null
                                  ? listInfo['creator']['nickname']
                                  : '加载中...',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12.0,
                              color: Colors.white,
                            )
                          ]),
                      Padding(padding: EdgeInsets.all(13)),
                      Row(
                        children: <Widget>[
                          Text(
                            '编辑信息',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12.0,
                            color: Colors.white,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 16)),
            ],
          ),
          box,
          box,
          Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 16)),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.comment,
                      color: Colors.white,
                    ),
                    Padding(padding: EdgeInsets.only(top: 5.0)),
                    Text('评论',
                        style: TextStyle(color: Colors.white, fontSize: 12.0))
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    Padding(padding: EdgeInsets.only(top: 5.0)),
                    Text('分享',
                        style: TextStyle(color: Colors.white, fontSize: 12.0))
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.file_download,
                      color: Colors.white,
                    ),
                    Padding(padding: EdgeInsets.only(top: 5.0)),
                    Text('下载',
                        style: TextStyle(color: Colors.white, fontSize: 12.0))
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.done_all,
                      color: Colors.white,
                    ),
                    Padding(padding: EdgeInsets.only(top: 5.0)),
                    Text('多选',
                        style: TextStyle(color: Colors.white, fontSize: 12.0))
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 16)),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 30),
            margin: EdgeInsets.only(top: 12),
            decoration: BoxDecoration(
                color: Color(0xffC4C4C4),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.play_circle_outline, color: Colors.red),
                      Padding(padding: EdgeInsets.only(left: 16)),
                      Text(
                        '含18首VIP专享歌曲',
                        style: TextStyle(color: MyColor.deepFont),
                      )
                    ],
                  ),
                ),
                Text(
                  '首开VIP仅5元',
                  style: TextStyle(
                      color: Colors.grey, fontSize: MyFontSize.midSize),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: MyColor.lightFont,
                  size: MyFontSize.midSize,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(listInfo['coverImgUrl']);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 0,
                  pinned: true,
                  brightness: Brightness.dark, // 黑底白字
                  backgroundColor: Color(0xff373737),
                  expandedHeight: 375,
                  iconTheme: IconThemeData(
                      color: Colors.white), // 所有icon的样式，不仅是左侧的，右侧的也会改变
                  title: Text(title, style: TextStyle(color: Colors.white)),
                  actions: <Widget>[
                    IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert),
                    )
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    // 堆叠在工具栏和标签栏后面，他的高度与应用栏的整体高度相同
                    collapseMode: CollapseMode
                        .pin, // 背景固定到位，直到最小范围。默认是parallax（将以视差方式滚动），还有一个none。滚动没有效果
                    background: Container(
                      // 背景，一般是一个图片，在title后面
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 80.0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            child: listInfo['coverImgUrl'] == null
                                ? null
                                : CachedNetworkImage(
                                    imageUrl: listInfo['coverImgUrl'],
                                    width: 750,
                                    height: 300,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Container(
                            // height: 120,
                            child: BackdropFilter(
                              // ImageFilter 图片模糊
                              filter:
                                  ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                              child: Container(
                                color: Color(0xff757575).withAlpha(1),
                              ),
                            ),
                          ),
                          _buildTitle(),
                        ],
                      ),
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(48.0),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(playLists.length > 0
                                  ? listInfo['coverImgUrl']
                                  : ''),
                              fit: BoxFit.fitHeight)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: Container(
                          padding: EdgeInsets.all(16),
                          color: Colors.white,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Icon(Icons.play_circle_outline),
                              ),
                              Padding(padding: EdgeInsets.only(left: 12)),
                              Text('播放全部'),
                              Text(
                                '(共${playLists.length}首)',
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff999999)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  final item = playLists[index];
                  return ListTile(
                    onTap: () async {
                      if (playLists[index]['fee'] == 0) return;
                      final songId = playLists[index]['id'].toString();
                      store.dispatch({
                        'type': 'setPlayingData',
                        'playload': {
                          'id': songId,
                          'playList': playLists,
                          'percent': 0.0,
                          'index': index
                        }
                      });
                      String id = songId;
                      await getSongDetail(id);
                      await getSongUrl(id);
                      await getLyric(id);
                      store
                          .dispatch({'type': 'changePlay', 'playload': 'play'});
                      store.state.playState['isNewPlay'] = true;
                      Navigator.of(context).pushNamed('/player');
                    },
                    title: Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 35,
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                  color: Color(0xffc909090), fontSize: 12.0),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    playLists[index]['name'],
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: MyColor.deepFont),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      playLists[index]['ar'][0]['name'],
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: MyColor.lightFont),
                                    ),
                                  )
                                ]),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.ondemand_video,
                              color: MyColor.lightFont,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 15)),
                          SongActionBtn(MyColor.lightFont, {
                            'imgUrl': item['al']['picUrl'],
                            'name': item['name'],
                            'ar': item['ar'],
                            'id': item['id']
                          })
                        ],
                      ),
                    ),
                  );
                }, childCount: playLists.length)),
                SliverToBoxAdapter(
                  child:
                      LoadMore(isLoading, isLoading ? '加载中...' : '- 没有更多了 -'),
                )
              ],
            ),
          ),
          PlayBar()
        ],
      ),
    );
  }
}
