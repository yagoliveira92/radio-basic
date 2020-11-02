import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:radio_basic/app/features/cover_album/domain/entities/music_metadata_entity.dart';

class CoverAlbumWidget extends StatelessWidget {
  const CoverAlbumWidget({@required this.musicMetadata});

  final MusicMetadataEntity musicMetadata;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      height: 320,
      child: Column(
        children: <Widget>[
          ClipOval(
            child: Image.network(
              musicMetadata.artworkUrl100,
              height: 230,
            ),
          ),
          Padding(
            child: Text(
              musicMetadata.trackName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.only(top: 22),
          ),
          Padding(
            child: Text(
              musicMetadata.artistName,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.only(top: 10),
          )
        ],
      ),
    );
  }
}
