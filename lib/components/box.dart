import 'package:flutter/material.dart';
import 'package:flutter_music/util/theme.dart';

final Widget box = Container(height: 10, child: null);

final Widget box_6 = Container(height: 6, child: null);

final Widget border = Container(
    width: double.maxFinite,
    height: 1,
    child: null,
    decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: MyColor.borderColor, width: 1))));
