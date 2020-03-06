import 'package:flutter/material.dart';
/***
 * 从网络获取图片，并保存到缓存，有占位图和加载出错图
 */
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_music/components/box.dart';
import 'package:flutter_music/util/theme.dart';

class ImageBlock extends StatelessWidget {
  final item;
  ImageBlock(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width / 3 - 30,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: item['picUrl'],
                  // height: 60.0,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 2),
                  ),
                  item['playcount'] != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                              Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: MyFontSize.midSize,
                              ),
                              Text(
                                (item['playcount'] ~/ 10000).toString() + '万',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: MyFontSize.smallSize),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 6, top: 6),
                              )
                            ])
                      : Container()
                ],
              )
            ],
          ),
          box,
          Text(
            item['name'],
            maxLines: 2,
            style: TextStyle(fontSize: 13.0),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
