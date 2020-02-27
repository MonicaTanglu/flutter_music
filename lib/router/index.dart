import 'package:flutter/material.dart';
import 'package:flutter_music/views/login.dart';
import 'package:flutter_music/views/login-1.dart';
import 'package:flutter_music/views/agreement.dart';
import 'package:flutter_music/views/login-2.dart';
import 'package:flutter_music/views/person.dart';
import 'package:flutter_music/views/setting.dart';
import 'package:flutter_music/views/mine.dart';

final routes = <String, WidgetBuilder>{
  '/login': (context) => LoginPage(),
  '/oneLogin': (context) => LoginOne(),
  '/agreement': (context) => Agreement(),
  '/twoLogin': (context) => LoginTwo(),
  '/setting': (context) => SettingPage(),
  '/mine': (context) => MinePage(),
  '/person': (context) => PersonPage()
};
