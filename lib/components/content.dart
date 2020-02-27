import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  final Widget child;

  Content({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(height: 44, child: child);
  }
}
