import 'package:flutter/material.dart';

final double viewPadding = 20.0;
const Color _defaultColor = Color(0xffffffff);

class Sample extends StatelessWidget {
  final String title;
  final String describe;
  final Widget child;
  final bool showPadding;
  final Color color;
  Sample(this.title,
      {describe, child, showPadding = true, color = _defaultColor})
      : this.showPadding = showPadding,
        this.describe = describe is String ? describe : null,
        this.child = child is Widget ? child : null,
        this.color = color;

  @override
  Widget build(BuildContext context) {
    // final Widget title = Align(
    //   alignment: Alignment.topLeft,
    //   child: Text(this.title, style: TextStyle(fontSize: 20)),
    // );
    final List<Widget> headChildren = [];
    if (describe is String) {
      headChildren.add(Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(describe,
              style: TextStyle(color: Color(0xff888888), fontSize: 14)),
        ),
      ));
    }
    final List<Widget> children = [
      Container(
          padding: EdgeInsets.all(20), child: Column(children: headChildren)),
      Padding(
        padding: EdgeInsets.only(
            left: showPadding ? viewPadding : 0.0,
            right: showPadding ? viewPadding : 0.0,
            bottom: viewPadding),
        child: child,
      )
    ];
    return Scaffold(
        appBar: AppBar(title: Text(this.title), elevation: 0),
        backgroundColor: color,
        body: ListView(children: children));
  }
}
