import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SongRecoment extends StatelessWidget {
  final item;
  SongRecoment(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
      width: MediaQuery.of(context).size.width - 40,
      child: Row(children: [
        Expanded(
          flex: 1,
          child: Row(children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: item['album']['picUrl'],
                  height: 48,
                  width: 48,
                )),
            Padding(
              padding: EdgeInsets.only(right: 6),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${item['name']}",
                  style: TextStyle(color: Color(0xff595959), fontSize: 12),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text('窗外下起了雨，雨滴在跳舞',
                      style: TextStyle(color: Color(0xffA5A5A5), fontSize: 10)),
                )
              ],
            )
          ]),
        ),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xffEDEDED))),
          child: Icon(
            Icons.play_arrow,
            color: Theme.of(context).accentColor,
            size: 14,
          ),
        )
      ]),
    );
  }
}
