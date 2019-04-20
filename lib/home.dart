import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:audio_service/audio_service.dart';
import 'dart:async';

const streamURL =
    "https://azuracast.tecnocampinfo.com.br/radio/8000/listen.mp3";

bool buttonState = true;

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

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer audioPlayer = new AudioPlayer();

  void buttonChange() {
    setState(() {
      if (buttonState) {
        AudioService.stop();
        buttonState = !buttonState;
      } else {
        AudioService.connect();
        AudioService.start(
          backgroundTask: _backgroundAudioPlayerTask,
          resumeOnClick: true,
          androidNotificationChannelName: 'ABC Rádio',
          notificationColor: 0x5E6263,
          androidNotificationIcon: 'mipmap/radio',
        );
        buttonState = !buttonState;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black12,
      padding: EdgeInsets.only(top: 230),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 65),
            child: Image(
              image: AssetImage('assets/logo.png'),
              width: 250,
            ),
          ),
          Container(width: double.infinity,
            color: Colors.black26,
            child: buildPlayer()
            )
        ]),
    );
  }

  Widget buildPlayer() {
    if (buttonState) {
      return IconButton(
          icon: Icon(Icons.pause_circle_outline),
          iconSize: 120,
          onPressed: buttonChange);
    } else {
      return IconButton(
          icon: Icon(Icons.play_circle_outline),
          iconSize: 120,
          onPressed: buttonChange);
    }
  }
}

void _backgroundAudioPlayerTask() async {
  CustomAudioPlayer player = CustomAudioPlayer();
  AudioServiceBackground.run(
    onStart: player.run,
    onPlay: player.play,
    onPause: player.pause,
    onStop: player.stop,
    onClick: (MediaButton button) => player.playPause(),
  );
}

class CustomAudioPlayer {
  static const streamUri =
      'https://azuracast.tecnocampinfo.com.br/radio/8000/listen.mp3';
  AudioPlayer _audioPlayer = new AudioPlayer();
  Completer _completer = Completer();
  bool _playing = true;

  Future<void> run() async {
    MediaItem mediaItem = MediaItem(
        id: 'audio_1', album: 'ABC Radio', title: 'A rádio que não cansa vc');

    AudioServiceBackground.setMediaItem(mediaItem);

    var playerStateSubscription = _audioPlayer.onPlayerStateChanged
        .where((state) => state == AudioPlayerState.COMPLETED)
        .listen((state) {
      stop();
    });
    play();
    await _completer.future;
    playerStateSubscription.cancel();
  }

  void playPause() {
    if (_playing)
      pause();
    else
      play();
  }

  void play() {
    _audioPlayer.play(streamUri);
    AudioServiceBackground.setState(
        controls: [pauseControl, stopControl],
        basicState: BasicPlaybackState.playing);
    buttonState = !buttonState;
  }

  void pause() {
    _audioPlayer.pause();
    AudioServiceBackground.setState(
        controls: [playControl, stopControl],
        basicState: BasicPlaybackState.paused);
  }

  void stop() {
    _audioPlayer.stop();
    AudioServiceBackground.setState(
        controls: [], basicState: BasicPlaybackState.stopped);
    _completer.complete();
    buttonState = !buttonState;
  }
}
