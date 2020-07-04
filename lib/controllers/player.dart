import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'dart:async';

const streamUrl = 'http://srv9.abcradio.com.br:7002/listen.mp3';

bool buttonState = true;

CustomAudioPlayer player = CustomAudioPlayer();

final playControl = MediaControl(
  androidIcon: 'drawable/ic_action_play_arrow',
  label: 'Play',
  action: MediaAction.play,
);
final pauseControl = MediaControl(
  androidIcon: 'drawable/ic_action_pause',
  label: 'Pause',
  action: MediaAction.pause,
);
final stopControl = MediaControl(
    androidIcon: 'drawable/ic_action_stop',
    label: 'Stop',
    action: MediaAction.stop);

class Player {
  Future initPlaying() async {
    AudioService.start(
      backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
      androidNotificationChannelName: 'Audio Service Demo',
      androidNotificationColor: 0xFF2196f3,
      androidNotificationIcon: 'mipmap/ic_launcher',
    );
  }

  pause() async {
    AudioService.pause();
  }

  play() async {
    if (await AudioService.running) {
      AudioService.play();
    } else {
      initPlaying();
    }
  }

  updateMedia(Map<String, dynamic> _media) async {
    await AudioService.customAction('updateMedia', _media);
  }
}

void _audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => CustomAudioPlayer());
}

class CustomAudioPlayer extends BackgroundAudioTask {
  MediaItem mediaItem = MediaItem(
      id: 'audio_1',
      album: 'Igreja em Aracaju',
      title: 'Jesus é Deus',
      artUri: 'https://tecnocamp.info/assets/noimageavailable.jpg');

  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
  }

  @override
  onStart(Map<String, dynamic> params) async {
    AudioServiceBackground.setMediaItem(mediaItem);
    AudioServiceBackground.setState(
        controls: [pauseControl, stopControl],
        playing: true,
        processingState: AudioProcessingState.ready);
    await audioStart();
    onPlay();
  }

  @override
  void onPlay() {
    AudioServiceBackground.setState(
        controls: [pauseControl, stopControl],
        playing: true,
        processingState: AudioProcessingState.ready);
    FlutterRadio.play(url: streamUrl);
  }

  @override
  void onPause() {
    AudioServiceBackground.setState(
        controls: [playControl, stopControl],
        playing: false,
        processingState: AudioProcessingState.ready);
    FlutterRadio.pause(url: streamUrl);
  }

  @override
  Future<void> onStop() async {
    await FlutterRadio.stop();
    exit(0);
    await super.onStop();
    await AudioServiceBackground.setState(
        controls: [],
        playing: false,
        processingState: AudioProcessingState.stopped);
  }

  @override
  Future onCustomAction(_function, params) {
    AudioServiceBackground.setMediaItem(MediaItem(
        id: params['mediaID'],
        album: params['mediaAlbum'],
        title: params['mediaTitle'],
        artUri: params['mediaCover']));
  }
}
