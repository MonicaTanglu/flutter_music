import 'package:flutter/material.dart';

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
              // unselectedLabelColor: const Color(0xFFA1A1A1),

              indicatorWeight: 0,
              isScrollable: true,
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
        return null;
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
