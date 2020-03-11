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

  static getTopListDetail(params, cb) {
    DioUtil.getInstance().getNoQuery('/toplist/detail', (data) {
      cb(data);
    }, (err) {
      cb(err);
    });
  }

  static getHotWallList(params, cb) {
    DioUtil.getInstance().get('/comment/hotwall/list', params, (data) {
      cb(data);
    }, (data) {
      cb(data);
    });
  }

  static getTopArtists(params, cb) {
    DioUtil.getInstance().get('/top/artists', params, (data) {
      cb(data);
    }, (data) {
      cb(data);
    });
  }

  static getTopPlayList(params, cb) {
    // /top/playlist
    DioUtil.getInstance().get('/event', params, (data) {
      cb(data);
    }, (data) {
      cb(data);
    });
  }
}
