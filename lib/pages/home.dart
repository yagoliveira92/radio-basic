import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:radiobasic/controllers/player.dart';
import 'package:radiobasic/pages/contato.dart';
import 'package:radiobasic/pages/cover_page.dart';
import 'package:radiobasic/pages/pedido_musica.dart';
import 'package:share/share.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  Player player = Player();
  AnimationController _animationController;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;
  Curve _curve = Curves.easeOut;
  PlaybackState state;
  bool buttonState = true;
  Color mainColor = Color(0xFFE47833);
  PageController _myPage = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _verificarConectividade();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      player.initPlaying();
    });
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
      begin: Colors.white,
      end: Colors.white,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.00,
          1.00,
          curve: _curve,
        ),
      ),
    );
  }

  Future _verificarConectividade() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Ops!'),
              content: Text('''Não foi possível conectar com a internet. 
Verifique sua conexão e tente novamente'''),
              actions: <Widget>[
                FlatButton(
                  child: Text('Fechar'),
                  onPressed: () => exit(0),
                )
              ],
            );
          });
    }
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void buttonChange(bool playing) {
    if (playing == AudioService.playbackState.playing) {
      _animationController.forward();
      player.pause();
    } else {
      _animationController.reverse();
      AudioService.play();
    }
  }

  Future<bool> _sairDoApp(BuildContext context) {
    return showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text('Tem certeza que deseja sair?'),
            content: new Text('O aplicativo será fechado'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Não'),
              ),
              new FlatButton(
                onPressed: () async {
                  AudioService.stop();
                  exit(0);
                  return true;
                },
                child: new Text('Sim'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _sairDoApp(context),
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: <Widget>[
            PageView(
              controller: _myPage,
              children: <Widget>[
                FirstPage(key: PageStorageKey('Home')),
                Contato(),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
            color: mainColor,
            shape: const CircularNotchedRectangle(),
            notchMargin: 5,
            child: Container(
              height: 90,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Color(0xFF055D6F),
                      size: 35,
                    ),
                    onPressed: () {
                      setState(() {
                        _myPage.jumpToPage(0);
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 120),
                    child: IconButton(
                      icon: Icon(Icons.mail_outline,
                          color: Color(0xFF055D6F), size: 35),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PedidoMusica()));
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Color(0xFF055D6F),
                      size: 35,
                    ),
                    onPressed: () {
                      Share.share(
                          "Ouça a rádio que edifica você: https://play.google.com/store/apps/details?id=br.com.igrejaemaracaju.radio");
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.record_voice_over,
                      color: Color(0xFF055D6F),
                      size: 35,
                    ),
                    onPressed: () {
                      setState(() {
                        _myPage.jumpToPage(1);
                      });
                    },
                  )
                ],
              ),
            )),
        floatingActionButton: StreamBuilder<PlaybackState>(
            stream: AudioService.playbackStateStream,
            builder: (context, snapshot) {
              final playing = snapshot.data?.playing ?? false;
              return Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  height: 120,
                  width: 120,
                  child: FittedBox(
                    child: buildPlayer(playing),
                  ));
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget buildPlayer(bool playing) {
    if (playing == AudioService.playbackState.playing) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    return FloatingActionButton(
      backgroundColor: mainColor,
      onPressed: () => buttonChange(playing),
      child: Container(
          width: 120,
          margin: EdgeInsets.all(7.5),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFF055D6F), width: 3.2)),
          child: AnimatedIcon(
            icon: AnimatedIcons.pause_play,
            progress: _animateIcon,
            color: Color(0xFF055D6F),
            size: 35,
          )),
    );
  }
}
