import 'package:flutter/material.dart';
import 'package:flutter_music/views/home.dart';

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

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: choices.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0, // appBar的阴影，若没设置则默认为4
          title: TabBar(
              indicator: const BoxDecoration(),
              unselectedLabelColor: const Color(0xFFA1A1A1),
              isScrollable: true,
              labelStyle: new TextStyle(fontSize: 22.0),
              unselectedLabelStyle: new TextStyle(fontSize: 16.0),
              tabs: choices.map((Choice choice) {
                return Tab(text: choice.title);
              }).toList()),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            )
          ],
        ),
        // drawer: ,
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: TabBarView(
                  children: choices.map((Choice choice) {
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
  final Choice choice;
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (choice.component) {
      case 'home':
        return HomePage();
        break;
      case 'find':
        break;
      case 'cloud_valige':
        break;
      default:
        break;
    }
  }
}
