import 'package:flutter/material.dart';

class LoadingDialog extends Dialog {
  final String text;
  LoadingDialog({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material(
        type: MaterialType.transparency,
        child: Center(
            child: SizedBox(
                width: 120,
                height: 120,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(text),
                      )
                    ],
                  ),
                )))
        // )
        );
  }
}
