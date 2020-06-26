import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'dart:async';

import 'package:just_audio/just_audio.dart';

const streamUrl = 'http://srv9.abcradio.com.br:7002/listen.mp3';

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

void _backgroundTaskEntrypoint() =>
    AudioServiceBackground.run(() => CustomAudioPlayer());

class Player {
  initPlaying() async {
    await AudioService.start(
      backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
      androidNotificationChannelName: 'Audio Service Demo',
      androidNotificationColor: 0xFF2196f3,
      androidNotificationIcon: 'mipmap/ic_launcher',
    );
  }

  pause() {
    AudioService.pause();
  }
}

void _audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => CustomAudioPlayer());
}

class CustomAudioPlayer extends BackgroundAudioTask {
  final _audioPlayer = AudioPlayer();
  final _completer = Completer();

  @override
  Future<void> onStart(Map<String, dynamic> params) async {
    print("Iniciou o onStart");
    await _audioPlayer.setUrl(streamUrl);
    _audioPlayer.play();
  }

  // @override
  // void onPlay() {
  //   AudioServiceBackground.setState(
  //       controls: [pauseControl, stopControl],
  //       playing: true,
  //       processingState: AudioProcessingState.ready);
  //   _audioPlayer.play();
  // }

  // @override
  // void onPause() {
  //   AudioServiceBackground.setState(
  //       controls: [playControl, stopControl],
  //       playing: false,
  //       processingState: AudioProcessingState.ready);
  //   _audioPlayer.pause();
  // }

  @override
  Future<void> onStop() async {
    await _audioPlayer.stop();
    await super.onStop();
    // await AudioServiceBackground.setState(
    //     controls: [],
    //     playing: false,
    //     processingState: AudioProcessingState.stopped);
    // exit(0);
  }
}
