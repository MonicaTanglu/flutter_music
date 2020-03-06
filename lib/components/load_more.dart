import 'package:flutter/material.dart';
import 'package:flutter_music/util/theme.dart';

class LoadMore extends StatelessWidget {
  final bool loading;
  final String text;
  LoadMore(this.loading, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          loading
              ? SizedBox(
                  width: 16,
                  height: 16.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : Container(),
          loading
              ? Padding(
                  padding: EdgeInsets.only(left: 10),
                )
              : Container(),
          Text(
            text == null ? '加载中...' : text,
            style: TextStyle(
                fontSize: MyFontSize.smallSize, color: MyColor.lightFont),
          )
        ],
      ),
    );
  }
}
