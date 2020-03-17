import 'package:flutter/material.dart';
import 'package:flutter_music/views/home.dart';
import 'package:flutter_music/views/find.dart';
import 'package:flutter_music/components/drawer_content.dart';
import 'package:flutter_music/components/play_bar.dart';
import 'package:flutter_music/views/village.dart';
import 'package:flutter_music/views/video.dart';

class Choice {
  const Choice({this.title, this.icon, this.component});
  final String title;
  final IconData icon;
  final String component;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: '我的', icon: Icons.directions_car, component: 'home'),
  const Choice(title: '发现', icon: Icons.directions_bike, component: 'find'),
  const Choice(
      title: '云村', icon: Icons.directions_boat, component: 'cloud_valige'),
  const Choice(title: '视频', component: 'video')
];

class IndexPage extends StatefulWidget {
  @override
  _IndexPage createState() => new _IndexPage();
}

class _IndexPage extends State with SingleTickerProviderStateMixin {
  TabController _tabController;
  var tabSelected = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: choices.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: tabSelected == 0 ? Color(0xff25242A) : Colors.white,
          elevation: 0, // appBar的阴影，若没设置则默认为4
          leading: new IconButton(
              icon: new Icon(
                Icons.menu,
                color: tabSelected == 0 ? Colors.white : Color(0xFF555555),
              ),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              }),
          title: TabBar(
            controller: _tabController,
            indicator: const BoxDecoration(),
            unselectedLabelColor: const Color(0xFFA1A1A1),
            isScrollable: false,
            indicatorPadding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            labelStyle: new TextStyle(fontSize: 20.0),
            labelColor: tabSelected == 0 ? Colors.white : Color(0xFF555555),
            unselectedLabelStyle: new TextStyle(fontSize: 16.0),
            tabs: choices.map((Choice choice) {
              return Tab(
                  child: Text(
                choice.title,
                maxLines: 1,
                overflow: TextOverflow.visible,
              ));
            }).toList(),
            onTap: (int index) {
              setState(() {
                tabSelected = index;
              });
            },
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search,
                  color: tabSelected == 0 ? Colors.white : Color(0xFF555555)),
            )
          ],
        ),
        drawer: Drawer(
          child: DrawerContent(),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: TabBarView(
                  controller: _tabController,
                  children: choices.map((Choice choice) {
                    return ChoiceCard(choice: choice);
                  }).toList(),
                )),
            // PlayBar()
          ],
        ),
      ),
    );
  }
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    switch (choice.component) {
      case 'home':
        return HomePage();
        break;
      case 'find':
        return FindPage();
        break;
      case 'cloud_valige':
        // return null;
        return VillagePage();
        break;
      case 'video':
        return VideoPage();
      default:
        return HomePage();
        break;
    }
  }
}
