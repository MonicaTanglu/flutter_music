import 'package:flutter/material.dart';
import 'package:flutter_music/views/home.dart';
import 'package:flutter_music/views/find.dart';
import 'package:flutter_music/components/drawer_content.dart';

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
      title: '云村', icon: Icons.directions_boat, component: 'cloud_valige')
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
            isScrollable: true,
            labelStyle: new TextStyle(fontSize: 22.0),
            labelColor: tabSelected == 0 ? Colors.white : Color(0xFF555555),
            unselectedLabelStyle: new TextStyle(fontSize: 16.0),
            tabs: choices.map((Choice choice) {
              return Tab(child: Text(choice.title));
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
                    print(choice.component);
                    return ChoiceCard(choice: choice);
                  }).toList(),
                ))
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
        print('home component');
        return HomePage();
        break;
      case 'find':
        print('find component');
        return FindPage();
        break;
      case 'cloud_valige':
        print('cloud_valige component');
        return null;
        break;
      default:
        return HomePage();
        break;
    }
  }
}
