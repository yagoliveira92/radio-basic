import 'dart:async';
import 'dart:convert';
import 'package:abcradio/models/music_metadata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:cron/cron.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> metadata;
  String coverAlbum;
  String nameMusicShoutcast;
  String artistName;
  String musicName;
  bool noAlbum = false;
  Timer timer;
  List<String> responseShoutcast;
  var cron = new Cron();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 15), (timer) {
      getMetadata();
      setState(() {});
    });
  }

  Future getMetadata() async {
    var response = await http.get('http://stm16.abcaudio.tv:25584/7.html');
    if (response.statusCode == 200) {
      RegExp exp = RegExp('(?<=<body>)(.*)(?=<\/body>)');
      RegExpMatch matches = exp.firstMatch(utf8.decode(response.bodyBytes));
      responseShoutcast = matches.group(0).split(',');
      if (nameMusicShoutcast == responseShoutcast[6]) {
        return metadata;
      } else {
        var itunesResponse = await http.get(
            'https://itunes.apple.com/search?term=${responseShoutcast[6]}&limit=1');
        if (itunesResponse.statusCode == 200) {
          var responseJson = convert.jsonDecode(itunesResponse.body);
          if (responseJson['resultCount'] != 0) {
            noAlbum = false;
            metadata = responseJson['results']
                .map((m) => MusicMetadata.fromJson(m))
                .toList();
            coverAlbum = metadata[0].artworkUrl100;
            musicName = metadata[0].trackName;
            artistName = metadata[0].artistName;
          } else {
            metadata = [];
            noAlbum = true;
            coverAlbum = 'Erro';
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xFF1B203C),
          image: DecorationImage(
              image: ExactAssetImage('assets/background.jpg'),
              fit: BoxFit.cover)),
      child: Column(
        children: <Widget>[
          Center(
            heightFactor: 2.3,
            child: Image.asset(
              'assets/logo.png',
              scale: 2.3,
            ),
          ),
          Center(
              heightFactor: 0.9,
              child: Container(
                width: double.infinity,
                color: Colors.transparent,
                height: 320,
                child: FutureBuilder(
                  future: getMetadata(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return temporaryText();
                      default:
                        if (snapshot.hasError) {
                          return Container();
                        } else {
                          return musicAlbum();
                        }
                    }
                  },
                ),
              )),
        ],
      ),
    );
  }

  Widget musicAlbum() {
    if (!noAlbum) {
      return defaultArt();
    } else {
      return noAvaliableArt();
    }
  }

  Widget temporaryText() {
    if (coverAlbum == null) {
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF060C22)),
          strokeWidth: 6,
        ),
      );
    } else if (noAlbum) {
      return noAvaliableArt();
    } else {
      return defaultArt();
    }
  }

  Widget defaultArt() {
    return Column(
      children: <Widget>[
        Image.network(
          coverAlbum.replaceAll('100x100', '200x200'),
          height: 180,
        ),
        Padding(
          child: Text(
            musicName,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.only(top: 22),
        ),
        Padding(
          child: Text(
            artistName,
            style: TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.only(top: 10),
        )
      ],
    );
  }

  Widget noAvaliableArt() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/noimageavailable.jpg',
          height: 180,
        ),
        Padding(
          child: Text(
            'ABC Radio',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.only(top: 22),
        ),
        Padding(
          child: Text(
            'A rádio que não cansa você!',
            style: TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.only(top: 10),
        )
      ],
    );
  }
}
