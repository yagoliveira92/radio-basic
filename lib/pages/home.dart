import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:radiobasic/assets/redes_sociais_icons.dart';
import 'package:radiobasic/controllers/player.dart';
import 'package:radiobasic/pages/contato.dart';
import 'package:radiobasic/pages/cover_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  final player = GetIt.I.get<Player>();
  AnimationController _animationController;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;
  Curve _curve = Curves.easeOut;
  bool buttonState = true;
  Color mainColor = Color(0xFFE47833);
  PageController _myPage = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    player.initPlaying();
    _verificarConectividade();
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
        },
      );
    }
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void buttonChange() {
    if (AudioService.playbackState.playing) {
      _animationController.forward();
      player.pause();
    } else {
      _animationController.reverse();
      player.play();
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
    return AudioServiceWidget(
      child: WillPopScope(
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
                height: 70,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            RedesSociais.icn_radio_white,
                            color: Color(0xFF1B203C),
                            size: 35,
                          ),
                          onPressed: () {
                            setState(() {
                              _myPage.jumpToPage(0);
                            });
                          },
                        ),
                        Text(
                          "Rádio",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(RedesSociais.icn_whts,
                              color: Color(0xFF1B203C), size: 35),
                          onPressed: () {
                            launch(
                              "https://api.whatsapp.com/send?phone=5579981558855&text=Opa!%20Quero%20pedir%20uma%20m%C3%BAsica!",
                            );
                          },
                        ),
                        Text(
                          "Whatsapp",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 110,
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            RedesSociais.g24,
                            color: Color(0xFF1B203C),
                            size: 35,
                          ),
                          onPressed: () {
                            setState(() {
                              _myPage.jumpToPage(1);
                            });
                          },
                        ),
                        Text(
                          "Redes",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            RedesSociais.icn_cmprt,
                            color: Color(0xFF1B203C),
                            size: 35,
                          ),
                          onPressed: () {
                            Share.share(
                                '''Ouça a rádio que trás o melhor do flashback: 
https://play.google.com/store/apps/details?id=br.abcradio.web''');
                          },
                        ),
                        Text(
                          "Compartilhe",
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    )
                  ],
                ),
              )),
          floatingActionButton: StreamBuilder<PlaybackState>(
              stream: AudioService.playbackStateStream,
              builder: (context, snapshot) {
                return Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    height: 100,
                    width: 100,
                    child: FittedBox(
                      child: buildPlayer(),
                    ));
              }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }

  Widget buildPlayer() {
    if (AudioService.playbackState.playing) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    return FloatingActionButton(
      backgroundColor: mainColor,
      onPressed: () => buttonChange(),
      child: Container(
          width: 120,
          margin: EdgeInsets.all(7.5),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFF1B203C), width: 3.2)),
          child: AnimatedIcon(
            icon: AnimatedIcons.pause_play,
            progress: _animateIcon,
            color: Color(0xFF1B203C),
            size: 35,
          )),
    );
  }
}
