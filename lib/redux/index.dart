import 'package:meta/meta.dart';

@immutable
class PlayState {
  Map _playState;
  get playState => _playState;
  PlayState.initState() {
    _playState = {
      'play': 'stop',
      'isNewPlay': false,
      'playingData': {
        'id': '',
        'comentId': '',
        'playList': [],
        'index': null,
        'percent': null,
        'imgUrl': '',
        'mp3Url': '',
        'name': '',
        'musicPlayer': null,
        'controller': null,
        'lrc': '',
        'ar': null
      },
      'commentData': {'id': '', 'imgUrl': '', 'name': '', 'ar': []},
      'home': {'songlist': []}
    };
  }
  PlayState(this._playState);
}

PlayState reducer(PlayState state, action) {
  if (action['type'] == 'changePlay') {
    state.playState['play'] = action['playload'];
    return PlayState(state.playState);
  }
  if (action['type'] == 'setPlayingData') {
    //addEntries 合并两个map，如果key有重复，被合并的map的value覆盖前者
    state.playState['playingData'].addEntries(action['playload'].entries);
    return PlayState(state.playState);
  }
  if (action['type'] == 'setCommentData') {
    state.playState['commentData'].addEntries(action['playload'].entries);
    return PlayState(state.playState);
  }
  if (action['type'] == 'setHome') {
    state.playState['home'].addEntries(action['playload'].entries);
    return PlayState(state.playState);
  }
  return state;
}
