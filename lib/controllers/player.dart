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
  static final Player _singleton = Player._internal();

  factory Player() {
    return _singleton;
  }

  Player._internal();

  initPlaying() {
    connect();
    AudioService.start(
      backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
      androidNotificationChannelName: 'Audio Service Demo',
      androidNotificationColor: 0xFF2196f3,
      androidNotificationIcon: 'mipmap/ic_launcher',
    );
  }

  pause() => AudioService.pause();

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

void connect() async {
  await AudioService.connect();
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
    print('Audio Start OK');
  }

  @override
  onStart(Map<String, dynamic> params) async {
    print("Iniciou o onStart");
    AudioServiceBackground.setState(
        controls: [pauseControl, stopControl],
        playing: true,
        processingState: AudioProcessingState.ready);
    await FlutterRadio.audioStart();
    FlutterRadio.playOrPause(url: streamUrl);
    AudioServiceBackground.setMediaItem(mediaItem);
    AudioServiceBackground.setState(
        controls: [pauseControl, stopControl],
        playing: true,
        processingState: AudioProcessingState.ready);
  }

  @override
  void onPlay() {
    AudioServiceBackground.setState(
        controls: [pauseControl, stopControl],
        playing: true,
        processingState: AudioProcessingState.ready);
    FlutterRadio.playOrPause(url: streamUrl);
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
