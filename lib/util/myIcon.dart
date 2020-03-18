import 'package:flutter/cupertino.dart';

class MyIcons {
  //matchTextDirection 是否匹配文字的阅读习惯（从左到右）。如果为true,那么当设置从右往左时，图像会沿y轴翻转180展示
  static const IconData weChat =
      const IconData(0xe600, fontFamily: 'myIcon', matchTextDirection: true);

  static const IconData qq =
      const IconData(0xe882, fontFamily: 'myIcon', matchTextDirection: true);

  static const IconData weibo =
      const IconData(0xe75a, fontFamily: 'myIcon', matchTextDirection: true);
}
