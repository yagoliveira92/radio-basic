import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:radiobasic/controllers/player.dart';
import 'dart:convert' as convert;
import 'package:radiobasic/models/music_metadata.dart';
import 'package:mobx/mobx.dart';

part 'cover-controller.g.dart';

class CoverController = _CoverControllerBase with _$CoverController;

abstract class _CoverControllerBase with Store {
  List<dynamic> _metadata;

  @observable
  String coverAlbum = 'https://tecnocamp.info/assets/noimageavailable.jpg';

  @observable
  String artistName = '"Ide e fazei discípulos de todas as nações"';

  @observable
  String musicName = "Igreja em Aracaju";

  String _nameMusicShoutcast;
  List<String> responseShoutcast;

  var player = Player();

  @action
  Future getMetadata() async {
    var response = await http
        .get('http://srv9.abcradio.com.br:7002/7.html')
        .catchError((_) => print("Erro ao se comunicar com o Streaming!"));
    if (response.statusCode == 200) {
      RegExp exp = RegExp('(?<=<body>)(.*)(?=<\/body>)');
      RegExpMatch matches =
          exp.firstMatch(convert.utf8.decode(response.bodyBytes));
      responseShoutcast = matches.group(0).split(',');
      if (_nameMusicShoutcast == responseShoutcast[6]) {
        return _metadata;
      } else {
        _nameMusicShoutcast = responseShoutcast[6];
        var itunesResponse = await http.get(
            'https://itunes.apple.com/search?term=${responseShoutcast[6]}&limit=1');
        if (itunesResponse.statusCode == 200) {
          var responseJson = convert.jsonDecode(itunesResponse.body);
          if (responseJson['resultCount'] != 0) {
            _metadata = responseJson['results']
                .map((m) => MusicMetadata.fromJson(m))
                .toList();
            coverAlbum =
                _metadata[0].artworkUrl100.replaceAll('100x100', '300x300');
            musicName = _metadata[0].trackName;
            artistName = _metadata[0].artistName;
          } else {
            _metadata = [];
            musicName = "Igreja em Aracaju";
            artistName = '"Ide e fazei discípulos de todas as nações"';
            coverAlbum = 'https://tecnocamp.info/assets/noimageavailable.jpg';
          }
          var mediaItem = {
            'mediaID': 'audio_1',
            'mediaAlbum': artistName,
            'mediaTitle': musicName,
            'mediaCover': coverAlbum
          };
          player.updateMedia(mediaItem);
        }
      }
    }
  }
}
