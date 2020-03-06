import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_music/main.dart';

// Cupertino风格组件即IOS风格组件

class SliderStatePage extends StatelessWidget {
  double percent = 0.0;
  SliderStatePage(this.percent);
  @override
  Widget build(BuildContext context) {
    return Container(
      // CupertinoSlider仿苹果进度条  还有一个进度条Slider
      child: Slider(
        value: percent,
        onChanged: (e) {
          var data = store.state.playState['playingData'];
          data['percent'] = e;
          store.dispatch({'type': 'setPlayingData', 'playload': data});
        },
        activeColor: Colors.white,
        inactiveColor: Color(0xff8B8784),
      ),
    );
  }
}
