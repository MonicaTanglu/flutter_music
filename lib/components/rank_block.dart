import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music/util/theme.dart';

class RankBlock extends StatelessWidget {
  final item;
  RankBlock(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: item['coverImgUrl'],
                  placeholder: (context, url) => CircularProgressIndicator(),
                )),
            Padding(
              padding: EdgeInsets.only(left: 5, bottom: 6),
              child: Text(
                item['updateFrequency'],
                style: TextStyle(
                    color: Colors.white, fontSize: MyFontSize.smallerSize),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 6),
          child: Text(
            item['name'],
            style: TextStyle(
                color: MyColor.commonFont, fontSize: MyFontSize.smallSize),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    ));
  }
}
