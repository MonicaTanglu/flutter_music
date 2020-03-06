import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/main.dart';
import 'package:flutter_music/util/player.dart';
import 'package:flutter_music/util/theme.dart';
import 'package:weui/drawer/index.dart';

class SongActionBtn extends StatelessWidget {
  Color color;
  Map songInfo;
  List<Widget> children = [];
  List actions = [
    {
      'title': '下一首播放',
      'icon': Icon(
        Icons.play_arrow,
        color: MyColor.deepFont,
      ),
      'callback': () {}
    },
    {
      'title': '收藏到歌单',
      'icon': Icon(Icons.add_box, color: MyColor.deepFont),
      'callback': () {}
    },
    {
      'title': '下载',
      'icon': Icon(Icons.file_download, color: MyColor.deepFont),
      'callback': () {}
    },
    {
      'title': '评论',
      'icon': Icon(Icons.comment, color: MyColor.deepFont),
      'callback': () {}
    },
    {
      'title': '分享',
      'icon': Icon(Icons.share, color: MyColor.deepFont),
      'callback': () {}
    },
    {
      'title': '歌手',
      'icon': Icon(Icons.person, color: MyColor.deepFont),
      'callback': () {}
    },
    {
      'title': '专辑',
      'icon': Icon(Icons.album, color: MyColor.deepFont),
      'callback': () {}
    },
    {
      'title': '设为铃声',
      'icon': Icon(Icons.alarm, color: MyColor.deepFont),
      'callback': () {}
    },
    {
      'title': '查看视频',
      'icon': Icon(Icons.ondemand_video, color: MyColor.deepFont),
      'callback': () {}
    },
    {
      'title': '删除',
      'icon': Icon(Icons.delete_outline, color: MyColor.deepFont),
      'callback': () {}
    },
    {
      'title': '屏蔽歌手或歌曲',
      'icon': Icon(Icons.cancel, color: MyColor.deepFont),
      'callback': () {}
    },
  ];
  PlayerController audioPlayer = PlayerController();

  Function close;
  SongActionBtn(this.color, this.songInfo);
  void show(context) {
    showModalBottomSheet(
        context: context,
        builder: _build,
        backgroundColor: Color.fromRGBO(255, 255, 255, 0));
  }

  Widget _build(context) {
    children = [];
    actions[5]['title'] = '歌手：${songInfo['ar'][0]['name']}';
    for (int i = 0; i < actions.length; i++) {
      final item = actions[i];
      children.add(ListTile(
        onTap: () {
          switch (i) {
            case 3:
              final commentData = store.state.playState['commentData'];
              commentData['id'] = songInfo['id'];
              commentData['name'] = songInfo['name'];
              commentData['ar'] = songInfo['ar'];
              commentData['imgUrl'] = songInfo['imgUrl'];
              store.dispatch({
                'type': 'setCommentData',
                'playload': commentData,
              });
              Navigator.of(context).pushNamed('/comment');
              close();
          }
        },
        title: Row(
          children: <Widget>[
            item['icon'],
            Padding(
              padding: EdgeInsets.only(left: 6),
            ),
            Expanded(
              child: Container(
                child: Text(
                  item['title'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: MyColor.deepFont),
                ),
              ),
            )
          ],
        ),
      ));
    }

    return Container(
      height: 600,
      child: Scaffold(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0),
          body: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            child: MediaQuery.removePadding(
                // removeTop: true,
                context: context,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              bottom: BorderSide(
                                  color: MyColor.borderColor, width: 1))),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(3.0),
                                  child: CachedNetworkImage(
                                      height: 40,
                                      width: 40,
                                      fit: BoxFit.cover,
                                      imageUrl: songInfo['imgUrl'],
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator()),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(songInfo['name'],
                                        style:
                                            TextStyle(color: MyColor.deepFont)),
                                    Text(songInfo['ar'][0]['name'],
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: MyColor.lightFont))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: false,
                        children: ListTile.divideTiles(
                                tiles: children, context: context)
                            .toList(),
                      ),
                    )
                  ],
                )),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        show(context);
      },
      child: Icon(
        Icons.more_vert,
        color: color,
      ),
    );
  }
}
