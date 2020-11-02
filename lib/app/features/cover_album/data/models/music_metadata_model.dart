import 'dart:convert';

import 'package:radio_basic/app/features/cover_album/domain/entities/music_metadata_entity.dart';

class MusicMetadataModel extends MusicMetadataEntity {
  MusicMetadataModel({
    String artistName,
    String trackName,
    String collectionName,
    String artworkUrl100,
  }) : super(
            artistName: artistName,
            artworkUrl100: artworkUrl100,
            collectionName: collectionName,
            trackName: trackName);

  MusicMetadataModel copyWith({
    String artistName,
    String trackName,
    String collectionName,
    String artworkUrl100,
  }) {
    return MusicMetadataModel(
      artistName: artistName ?? this.artistName,
      trackName: trackName ?? this.trackName,
      collectionName: collectionName ?? this.collectionName,
      artworkUrl100: artworkUrl100 ?? this.artworkUrl100,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'artistName': artistName,
      'trackName': trackName,
      'collectionName': collectionName,
      'artworkUrl100': artworkUrl100,
    };
  }

  factory MusicMetadataModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MusicMetadataModel(
      artistName: map['artistName'],
      trackName: map['trackName'],
      collectionName: map['collectionName'],
      artworkUrl100: map['artworkUrl100'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MusicMetadataModel.fromJson(String source) =>
      MusicMetadataModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MusicMetadataModel(artistName: $artistName, trackName: $trackName, collectionName: $collectionName, artworkUrl100: $artworkUrl100)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MusicMetadataModel &&
        o.artistName == artistName &&
        o.trackName == trackName &&
        o.collectionName == collectionName &&
        o.artworkUrl100 == artworkUrl100;
  }

  @override
  int get hashCode {
    return artistName.hashCode ^
        trackName.hashCode ^
        collectionName.hashCode ^
        artworkUrl100.hashCode;
  }
}
