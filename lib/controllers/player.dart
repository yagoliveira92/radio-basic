import 'package:audio_service/audio_service.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'dart:async';

const streamUrl =
    'http://stm16.abcaudio.tv:25584/player.mp3';

bool buttonState = true;

CustomAudioPlayer player = CustomAudioPlayer();

MediaControl playControl = MediaControl(
  androidIcon: 'drawable/ic_action_play_arrow',
  label: 'Play',
  action: MediaAction.play,
);
MediaControl pauseControl = MediaControl(
  androidIcon: 'drawable/ic_action_pause',
  label: 'Pause',
  action: MediaAction.pause,
);
MediaControl stopControl = MediaControl(
    androidIcon: 'drawable/ic_action_stop',
    label: 'Stop',
    action: MediaAction.stop);

class Player {
  initPlaying() {
    connect();
    AudioService.start(
      backgroundTaskEntrypoint: _backgroundAudioPlayerTask,
      resumeOnClick: true,
      androidNotificationChannelName: 'ABC Rádio',
      notificationColor: 0x5E6263,
      androidNotificationIcon: 'mipmap/radio',
    );
  }
}

void connect() async {
  await AudioService.connect();
}

void _backgroundAudioPlayerTask() async {
  AudioServiceBackground.run(() => CustomAudioPlayer());
}

class CustomAudioPlayer extends BackgroundAudioTask {
  bool _playing;
  Completer _completer = Completer();
  MediaItem mediaItem = MediaItem(
      id: 'audio_1',
      album: 'ABC Radio',
      title: 'A rádio que não cansa vc');

  Future<void> onStart() async {
    AudioServiceBackground.setMediaItem(mediaItem);
    audioStart();
    onPlay();
    await _completer.future;
  }

  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
  }

  void playPause() {
    if (_playing)
      onPause();
    else
      onPlay();
  }

  void onPlay() {
    FlutterRadio.play(url: streamUrl);
    _playing = true;
    AudioServiceBackground.setState(
        controls: [pauseControl, stopControl],
        basicState: BasicPlaybackState.playing);
  }

  void onPause() {
    FlutterRadio.playOrPause(url: streamUrl);
    AudioServiceBackground.setState(
        controls: [playControl, stopControl],
        basicState: BasicPlaybackState.paused);
  }

  void onStop() {
    FlutterRadio.stop();
    AudioServiceBackground.setState(
        controls: [], basicState: BasicPlaybackState.stopped);
    _completer.complete();
  }
}
