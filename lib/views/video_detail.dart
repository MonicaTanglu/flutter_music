import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_music/components/loading_dialog.dart';
import 'package:flutter_music/server/api.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter_music/util/theme.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_music/layout/rowPading.dart';
import 'package:flutter_music/components/box.dart';

class VideoDetail extends StatefulWidget {
  @override
  _VideoDetail createState() => new _VideoDetail();
}

class _VideoDetail extends State {
  String id = '';
  bool isLoading = false;
  List relVideos = [];
  String videoUrl = '';
  Map detail;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  @override
  void initState() {
    super.initState();
  }

  getVideoDetail(id) {
    Api.getVideoDetail({'id': id}, (data) {
      if (data['code'] == 200) {
        detail = data['data'];
      }
    });
  }

  getRelativeVideos(id) {
    Api.getRelativeVideo({'id': id}, (data) {
      if (data['code'] == 200) {
        relVideos = data['data'];
      }
    });
  }

  getVideoUrl(id) {
    setState(() {
      isLoading = true;
    });
    Api.getVideoUrl({'id': id}, (data) {
      if (data['code'] == 200) {
        videoUrl = data['urls'][0]['url'];
        videoPlayerController =
            VideoPlayerController.network(data['urls'][0]['url']);
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          aspectRatio: 16 / 9,
          autoPlay: true,
          looping: false,
        );
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  Widget getTagsWidget(tags) {
    List<Widget> children = [];
    for (int i = 0; i < tags.length; i++) {
      children.add(Container(
        padding: EdgeInsets.all(4),
        margin: EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Color(0xffF3F3F3)),
        child: Text(
          tags[i]['name'],
          style: TextStyle(
              fontSize: MyFontSize.smallSize, color: MyColor.lightFont),
        ),
      ));
    }
    return Container(
      height: 24,
      child: Wrap(
        runSpacing: 2,
        children: children,
        // mainAxisAlignment: MainAxisAlignment.,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (id == '') {
      dynamic args = ModalRoute.of(context).settings.arguments;
      id = args['videoId'];
      getVideoUrl(id);
      getVideoDetail(id);
      getRelativeVideos(id);
    }
    List videoTags = detail['videoGroup'];
    return Scaffold(
        body: isLoading && relVideos.length == 0 && videoUrl == ''
            ? LoadingDialog(
                text: '加载中...',
              )
            : AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.light,
                child: Container(
                  color: Colors.white,
                  child: Column(children: [
                    Center(
                        child: Chewie(
                      controller: chewieController,
                    )),
                    ListView(
                      padding: EdgeInsets.only(top: 6, bottom: 16),
                      shrinkWrap: true,
                      children: <Widget>[
                        RowPadding(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                              detail['title'],
                              style: TextStyle(fontWeight: FontWeight.w500),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Color(0xff878787),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                        ),
                        RowPadding(
                          children: <Widget>[
                            Text(
                              (detail['playTime'] / 1000).round().toString() +
                                  '万次观看',
                              style: TextStyle(
                                  fontSize: MyFontSize.smallSize,
                                  color: MyColor.lightFont),
                            ),
                            Expanded(
                              child: getTagsWidget(detail['videoGroup']),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 14),
                        ),
                        RowPadding(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.thumb_up,
                                    color: Color(0xff9E9E9E),
                                  ),
                                  Text(
                                    detail['praisedCount'].toString(),
                                    style: TextStyle(
                                        color: MyColor.lightFont,
                                        fontSize: MyFontSize.smallerSize),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.control_point,
                                      color: Color(0xff9E9E9E)),
                                  Text(
                                    detail['subscribeCount'].toString(),
                                    style: TextStyle(
                                        color: MyColor.lightFont,
                                        fontSize: MyFontSize.smallerSize),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.message, color: Color(0xff9E9E9E)),
                                  Text(
                                    detail['commentCount'].toString(),
                                    style: TextStyle(
                                        color: MyColor.lightFont,
                                        fontSize: MyFontSize.smallerSize),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.share, color: Color(0xff9E9E9E)),
                                  Text(
                                    detail['shareCount'].toString(),
                                    style: TextStyle(
                                        color: MyColor.lightFont,
                                        fontSize: MyFontSize.smallerSize),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                        ),
                        border,
                        box,
                        RowPadding(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      detail['creator']['avatarUrl'],
                                      width: 30,
                                      height: 30,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 6),
                                    child: Text(
                                      detail['creator']['nickname'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 4, bottom: 4, left: 8, right: 8),
                                child: Text(
                                  '+ 关注',
                                  style: TextStyle(
                                      color: Colors.white,
                                      wordSpacing: 2,
                                      fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ]),
                )));
  }
}
