import 'package:abcradio/pages/contato.dart';
import 'package:abcradio/pages/home_page.dart';
import 'package:abcradio/pages/pedido_musica.dart';
import 'package:flutter/material.dart';
import 'package:abcradio/controllers/player.dart';
import 'package:audio_service/audio_service.dart';
import 'package:share/share.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  void initState() {
    super.initState();
    player.initPlaying();
  }

  Player player = Player();
  PlaybackState state;

  bool buttonState = true;
  Color mainColor = Color(0xFF1B203C);
  PageController _myPage = PageController(initialPage: 0);

  void buttonChange() {
    setState(() {
      if (state?.basicState == BasicPlaybackState.playing) {
        AudioService.pause();
      } else {
        AudioService.play();
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          title: Text('ABC Rádio'),
          centerTitle: true,
          backgroundColor: mainColor,
        ),
      ),
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _myPage,
            children: <Widget>[
              Home(),
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
                    color: Colors.white,
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
                    icon: Icon(
                        Icons.mail_outline, color: Colors.white, size: 35),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PedidoMusica()));
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 35,
                  ),
                  onPressed: () {
                    Share.share(
                        "Acompanhe a melhor rádio do Flashback em: https://play.google.com/store/apps/details?id=br.abcradio.web");
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.record_voice_over,
                    color: Colors.white,
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
      floatingActionButton: StreamBuilder(
          stream: AudioService.playbackStateStream,
          builder: (context, snapshot) {
            state = snapshot.data;
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle
              ),
              height: 120,
              width: 120,
              child: FittedBox(
                child: FloatingActionButton(
                    backgroundColor: mainColor,
                    onPressed: () {},
                    child: buildPlayer(state)),
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildPlayer(PlaybackState state) {
    if (state?.basicState == BasicPlaybackState.playing) {
      return IconButton(
          icon: Icon(
            Icons.pause_circle_outline,
            color: Color(0xFFF8665E),
          ),
          iconSize: 40,
          onPressed: buttonChange);
    } else {
      return IconButton(
          icon: Icon(
            Icons.play_circle_outline,
            color: Color(0xFFF8665E),
          ),
          iconSize: 40,
          onPressed: buttonChange);
    }
  }
}
