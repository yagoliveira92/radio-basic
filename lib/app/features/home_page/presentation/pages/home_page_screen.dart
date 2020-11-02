import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:radio_basic/app/core/fonts/redes_sociais_icons.dart';
import 'package:radio_basic/app/features/cover_album/presentation/pages/cover_album_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return AudioServiceWidget(
      child: WillPopScope(
        onWillPop: () => alertExit(context: context, playPause: () {}),
        child: Scaffold(
          extendBody: true,
          body: Stack(
            children: <Widget>[
              PageView(
                controller: _myPage,
                children: <Widget>[
                  CoverAlbumScreen(),
                  Contato(),
                ],
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            color: mainColor,
            shape: const CircularNotchedRectangle(),
            notchMargin: 5,
            child: 
          ),
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

  Future<bool> alertExit({BuildContext context, VoidCallback playPause}) {
    return showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Tem certeza que deseja sair?'),
            content: Text('O aplicativo será fechado'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Não'),
              ),
              FlatButton(
                onPressed: playPause,
                child: Text('Sim'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
