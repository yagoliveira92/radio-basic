import 'package:flutter/material.dart';
import 'package:radio_basic/jam_icon_app_icons.dart';
import 'package:radio_basic/home.dart';
import 'package:radio_basic/social.dart';
import 'package:radio_basic/contact.dart';
import 'package:audioplayer/audioplayer.dart';
import 'package:audio_service/audio_service.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: Main(),
  ));
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
    AudioService.connect();
    AudioService.start(
      backgroundTask: _backgroundAudioPlayerTask,
      resumeOnClick: true,
      androidNotificationChannelName: 'ABC Rádio',
      notificationColor: 0x5E6263,
      androidNotificationIcon: 'mipmap/radio',
    );
  }

  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    Social(),
    Contact(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.grey,
        onTap: onTabTapped,
        currentIndex: _currentIndex, // new// new
        items: [
          BottomNavigationBarItem(
            icon: new Icon(JamIconApp.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.alternate_email),
            title: new Text('Social'),
          ),
          BottomNavigationBarItem(
              icon: Icon(JamIconApp.contact), title: Text('Contato'))
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
