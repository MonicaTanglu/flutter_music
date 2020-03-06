import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import "package:flutter_music/redux/index.dart";
import 'package:flutter_music/util/player.dart';
import 'package:flutter_music/main.dart';
import 'package:flutter_music/util/theme.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PlayBar extends StatefulWidget {
  @override
  _PlayBar createState() => new _PlayBar();
}

class _PlayBar extends State with TickerProviderStateMixin {
  AnimationController controller;
  Duration total = Duration(seconds: 0);
  double _percent = 0.0;
  PlayerController audioPlayer = PlayerController();

  @override
  void initState() {
    super.initState();
    // vsync 存在时会防止屏幕外动画（动画的UI不在当前屏幕时）消耗不必要的资源
    controller =
        AnimationController(duration: const Duration(seconds: 14), vsync: this);
    audioPlayer.onDurationChanged((Duration d) {
      total = d;
    });

    audioPlayer.onAudioPositionChanged((Duration p) {
      if (total == null || audioPlayer == null) return;
      final passed = total.inMilliseconds - p.inMilliseconds;
      if (passed > 1000 || passed <= 0) {
        if (!mounted) return;
        setState(() {
          _percent = p.inMilliseconds / total.inMilliseconds;
        });
      }
      if (passed <= 1000) {
        store.dispatch({'type': 'changePlay', 'playload': 'stop'});
        audioPlayer.next();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = store.state.playState;
    if (state['play'] == 'play') {
      controller.repeat();
    } else {
      controller.stop();
    }
    return StoreConnector<PlayState, Map>(
      converter: (store) => state,
      builder: (context, play) {
        int len = play['playingData']['playList'].length;
        if (play['play'] == 'play') {
          controller.repeat();
        }
        return len > 0
            ? InkWell(
                onTap: () {
                  state['isNewPlay'] = false;
                  Navigator.of(context).pushNamed('/player');
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(
                              color: MyColor.borderColor, width: 0.5))),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 1,
                        // LinearProgressIndicator是一个线性、条状的进度条
                        child: LinearProgressIndicator(
                          value: _percent,
                          backgroundColor: Colors.white,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Colors.red), // 对进度条应用固定颜色
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 6.0, right: 6.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Container(
                                      child: play['playingData']['imgUrl'] ==
                                                  null ||
                                              play['playingData']['imgUrl'] ==
                                                  ''
                                          ? Icon(
                                              Icons.album,
                                              size: 45,
                                            )
                                          : RotationTransition(
                                              turns: controller,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: CachedNetworkImage(
                                                  imageUrl: play['playingData']
                                                      ['imgUrl'],
                                                  width: 45,
                                                  height: 45,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                    )),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          play['playingData']['name'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: MyColor.deepFont),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('横滑可以切换上下首哦',
                                            style: TextStyle(
                                                fontSize: MyFontSize.smallSize,
                                                color: MyColor.lightFont)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              StoreConnector<PlayState, VoidCallback>(
                                converter: (store) {
                                  return () {
                                    if (play['play'] != 'play') {
                                      store.dispatch({
                                        'type': 'changePlay',
                                        'playload': 'play'
                                      });
                                      audioPlayer.resume();
                                      controller.forward();
                                    } else {
                                      store.dispatch({
                                        'type': 'changePlay',
                                        'playload': 'puase'
                                      });
                                      audioPlayer.pause();
                                      controller.stop();
                                    }
                                  };
                                  // callback 是申明的转化参数（converter）的返回值，返回值类型视传入的泛型类型而定
                                },
                                builder: (context, callback) {
                                  return IconButton(
                                    icon: Icon(
                                      play['play'] != 'play'
                                          ? Icons.play_arrow
                                          : Icons.pause,
                                      size: 32,
                                      color: MyColor.lightFont,
                                    ),
                                    onPressed: callback,
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.menu),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : Container();
      },
    );
  }

  @override
  void dispose() {
    if (controller != null) {
      controller.stop();
      controller.dispose();
    }
    if (audioPlayer != null) {
      audioPlayer.destroy();
      audioPlayer = null;
    }
    super.dispose();
  }
}
