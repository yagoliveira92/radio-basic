import 'package:abcradio/models/music_metadata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> metadata;

  @override
  void initState() {
    getMetadata();
    super.initState();
  }

  Future getMetadata() async {
    var response = await http.get('http://stm16.abcaudio.tv:25584/7.html');
    if (response.statusCode == 200) {
      RegExp exp = RegExp('(?<=<body>)(.*)(?=<\/body>)');
      RegExpMatch matches = exp.firstMatch(response.body);
      List<String> musicName = matches.group(0).split(',');
      var itunesResponse = await http.get('https://itunes.apple.com/search?term=${musicName[6]}&limit=1');
      if (itunesResponse.statusCode == 200) {
        var responseJson = convert.jsonDecode(itunesResponse.body);
        metadata = responseJson['results'].map((m) => MusicMetadata.fromJson(m)).toList();
       return metadata;
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
              fit: BoxFit.cover
          )
      ),
      child: Column(
        children: <Widget>[
          Center(
            heightFactor: 2.6,
            child: Image.asset('assets/logo.png', scale: 2,),
          ),
          Center(
              heightFactor: 1,
              child: Opacity(
                opacity: 0.3,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  height: 300,
                  child: FutureBuilder(
                    future: getMetadata(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF060C22)),
                              strokeWidth: 6,
                            ),
                          );
                        default:
                          if (snapshot.hasError) {
                            return Container();
                          } else {
                            return Image.network(metadata[0].artworkUrl100);
                          }
                      }
                    },
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }
}
