import 'package:flutter/material.dart';

class RowPadding extends StatelessWidget {
  final List<Widget> children;
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
  RowPadding({this.children, mainAxisAlignment})
      : this.mainAxisAlignment = mainAxisAlignment is MainAxisAlignment
            ? mainAxisAlignment
            : MainAxisAlignment.start;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: children,
        ));
  }
}
