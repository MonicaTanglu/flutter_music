import 'dart:ui';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/components/slider.dart';
import 'package:flutter_music/util/player.dart';
import 'package:flutter_music/main.dart';
import 'package:flutter/services.dart';
import 'package:flutter_music/util/theme.dart';
import 'package:flutter_music/components/box.dart';
import 'package:flutter_music/redux/index.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PlayerPage extends StatefulWidget {
  @override
  _PlayerPage createState() => new _PlayerPage();
}

class _PlayerPage extends State with TickerProviderStateMixin {
  AnimationController controller;
  String id;
  String playUrl;
  bool showLrc = false;
  bool isNew = false;
  bool playing = false;
  double _percent = 0.0;
  Duration total = Duration(seconds: 0);
  Duration duration = Duration(seconds: 0);
  Duration leftTime = Duration(seconds: 0);
  PlayerController audioPlayer = PlayerController();

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 14), vsync: this);
    _initPlayer();
    if (store.state.playState['play'] == 'play') {
      controller.repeat();
    } else {
      controller.stop();
    }
    id = store.state.playState['playingData']['id'].toString();
  }

  _initPlayer() {
    audioPlayer.onDurationChanged((Duration d) {
      total = d;
    });
    // 大概200ms时间间隔
    audioPlayer.onAudioPositionChanged((Duration p) {
      if (total == null || audioPlayer == null) return;
      if (duration == null) duration = p;
      final passed = p.inMilliseconds - duration.inMilliseconds;
      if (passed > 1000 || passed <= 0) {
        if (!mounted) return;
        setState(() {
          duration = p;
          leftTime = total - duration;
          _percent = p.inMilliseconds / total.inMilliseconds;
        });
      }

      if ((total.inMilliseconds - p.inMilliseconds) <= 1000) {
        store.dispatch({'type': 'changePlay', 'playload': 'stop'});
        audioPlayer.next();
      }
    });
    final playStatus = store.state.playState['play'];
    isNew = store.state.playState['isNewPlay'];
    if (playStatus == 'play' && isNew) {
      playMusic();
    }
  }

  playMusic() async {
    stop();
    setState(() {
      playing = true;
    });
    playUrl = store.state.playState['playingData']['mp3Url'];
    audioPlayer.play(playUrl);
    store.dispatch({'type': 'changePlay', 'playload': 'play'});
  }

  stop() {
    setState(() {
      playing = false;
    });
    audioPlayer.stop();
  }

  pause() {
    setState(() {
      playing = false;
    });
    audioPlayer.pause();
  }

  resume() async {
    setState(() {
      playing = true;
    });
    if (playUrl == null && isNew) {
      playMusic();
      return;
    }
    audioPlayer.resume();
  }

  @override
  Widget build(BuildContext context) {
    final play = store.state.playState;
    final Color lightColor = Color(0xffE2DEDB);
    // print(play['playingData']);
    List durationList = duration.toString().split('.')[0].split(":");
    List leftTimeList = leftTime.toString().split('.')[0].split(":");
    return Scaffold(
        backgroundColor: Color(0xff6d6f6c),
        // AnnotatedRegion 设置状态栏字体黑白颜色
        // 设置沉浸式状态栏
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: play['playingData']['imgUrl'] == null
                      ? null
                      : CachedNetworkImage(
                          imageUrl: play['playingData']['imgUrl'],
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                ),
                // BackdropFilter实现高斯模糊的效果。如果不设置大小的话是全屏
                //ImageFilter 对图像进行平滑、锐化、边界增强等滤波处理 dart:ui
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: Container(
                    color: Colors.red.withAlpha(20),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              top: MediaQueryData.fromWindow(window)
                                  .padding
                                  .top)),
                      Row(
                        children: <Widget>[
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Theme.of(context).primaryColor,
                              )),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  play['playingData']['name'] == null
                                      ? ''
                                      : play['playingData']['name'],
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.white),
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                ),
                                Text(
                                    play['playingData']['ar'] == null
                                        ? ''
                                        : play['playingData']['ar'][0]['name'],
                                    style: TextStyle(
                                        fontSize: MyFontSize.smallSize,
                                        color: Color(0xffc0c0c0)))
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.share, color: Colors.white),
                          )
                        ],
                      ),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            showLrc
                                ? Container()
                                : Container(
                                    alignment: Alignment.topCenter,
                                    padding: EdgeInsets.only(top: 80),
                                    height: 350,
                                    child: Stack(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Image(
                                              image: AssetImage(
                                                  'lib/assets/images/circle_bg.png'),
                                              width: 280,
                                              height: 280),
                                        ),
                                        Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(90),
                                            child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    showLrc = true;
                                                  });
                                                },
                                                child: RotationTransition(
                                                    turns: controller,
                                                    child: play['playingData']
                                                                ['imgUrl'] ==
                                                            null
                                                        ? null
                                                        : CachedNetworkImage(
                                                            imageUrl: play[
                                                                    'playingData']
                                                                ['imgUrl'],
                                                            width: 180,
                                                            height: 180,
                                                            fit: BoxFit.cover,
                                                            placeholder: (context,
                                                                    url) =>
                                                                CircularProgressIndicator(),
                                                          ))),
                                          ),
                                        )
                                      ],
                                    )),
                            showLrc
                                ? Container()
                                : Padding(
                                    padding: EdgeInsets.only(left: 85),
                                    child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Transform(
                                          transform: new Matrix4.rotationZ(
                                              playing ? 0 : -pi / 9),
                                          child: Image(
                                            image: AssetImage(
                                                'lib/assets/images/changzhen.png'),
                                            width: 120,
                                          ),
                                        )),
                                  ),
                            showLrc
                                ? SingleChildScrollView(
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(20),
                                      child: InkWell(
                                          onTap: () {
                                            setState(() {});
                                          },
                                          child: Text(
                                            play['playingData']['lrc'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0),
                                            textAlign: TextAlign.center,
                                          )),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(left: 16)),
                              Expanded(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: lightColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.file_download,
                                    color: lightColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.surround_sound,
                                    color: lightColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.comment,
                                    color: lightColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: lightColor,
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(right: 16)),
                            ],
                          ),
                          box,
                          Padding(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: Row(children: [
                              Container(
                                alignment: Alignment.center,
                                width: 50,
                                child: Text(
                                  "${durationList[1]}:${durationList[2]}",
                                  style: TextStyle(
                                      color: lightColor,
                                      fontSize: MyFontSize.smallSize),
                                ),
                              ),
                              Expanded(
                                child: SliderStatePage(_percent),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 50,
                                child: Text(
                                  "${leftTimeList[1]}:${leftTimeList[2]}",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: MyFontSize.smallSize),
                                ),
                              )
                            ]),
                          ),
                          box,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.loop,
                                    color: lightColor,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.skip_previous,
                                    color: lightColor,
                                  ),
                                  onPressed: () {
                                    try {
                                      audioPlayer.prev();
                                      controller.repeat();
                                    } catch (e) {
                                      controller.stop();
                                    }
                                  },
                                ),
                              ),
                              Expanded(
                                child: StoreConnector<PlayState, VoidCallback>(
                                    converter: (store) {
                                  return () {
                                    if (play['play'] != 'play') {
                                      resume();
                                      store.dispatch({
                                        'type': 'changePlay',
                                        'playload': 'play'
                                      });
                                      controller.repeat();
                                    } else {
                                      store.dispatch({
                                        'type': 'changePlay',
                                        'playload': 'puase'
                                      });
                                      controller.stop();
                                      pause();
                                    }
                                  };
                                }, builder: (context, callback) {
                                  if (play['playingData']['playList'].length ==
                                      0) {
                                    Navigator.of(context).pop();
                                  }
                                  return IconButton(
                                    icon: Icon(
                                      play['play'] != 'play'
                                          ? Icons.play_arrow
                                          : Icons.pause,
                                      color: Colors.white,
                                    ),
                                    onPressed: callback,
                                  );
                                }),
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    try {
                                      audioPlayer.next();
                                      controller.repeat();
                                    } catch (e) {
                                      controller.stop();
                                    }
                                  },
                                  icon: Icon(
                                    Icons.skip_next,
                                    color: lightColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.list,
                                    color: lightColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 20,
                            child: null,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
