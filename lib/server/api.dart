import 'package:flutter_music/util/request.dart';

class Api {
  static getMsgPrivate(params, cb) {
    DioUtil.getInstance().get('/msg/private', params, (data) {
      cb(data);
    }, (data) {
      cb(data);
    });
  }

  static getPlayList(params, cb) {
    DioUtil.getInstance().get('/playlist/detail', params, (data) {
      cb(data);
    }, (data) {
      cb(data);
    });
  }

  static getUserSongSheet(params, cb) {
    DioUtil.getInstance().get('/user/playlist', params, (data) {
      cb(data);
    }, (data) {
      cb(data);
    });
  }
}
