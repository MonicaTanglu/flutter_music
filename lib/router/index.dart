import 'package:flutter/material.dart';
import 'package:flutter_music/views/index.dart';
import 'package:flutter_music/views/information.dart';
import 'package:flutter_music/views/login.dart';
import 'package:flutter_music/views/login-1.dart';
import 'package:flutter_music/views/agreement.dart';
import 'package:flutter_music/views/login-2.dart';
import 'package:flutter_music/views/person.dart';
import 'package:flutter_music/views/player.dart';
import 'package:flutter_music/views/rank.dart';
import 'package:flutter_music/views/setting.dart';
import 'package:flutter_music/views/mine.dart';
import 'package:flutter_music/views/song_list.dart';
// import 'package:flutter_music/views/village.dart';

final routes = <String, WidgetBuilder>{
  '/login': (context) => LoginPage(),
  '/oneLogin': (context) => LoginOne(),
  '/agreement': (context) => Agreement(),
  '/twoLogin': (context) => LoginTwo(),
  '/setting': (context) => SettingPage(),
  '/mine': (context) => MinePage(),
  '/person': (context) => PersonPage(),
  '/information': (context) => InformationPage(),
  '/index': (context) => IndexPage(),
  '/songlist': (context) => SongListPage(),
  '/player': (context) => PlayerPage(),
  '/rank': (context) => RankPage(),
  // '/village': (context) => VillagePage()
};
