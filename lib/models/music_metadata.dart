class MusicMetadata {
  String artistName;
  String trackName;
  String collectionName;
  String artworkUrl100;

  MusicMetadata(this.artistName, this.trackName, this.collectionName, this.artworkUrl100);

  factory MusicMetadata.fromJson(Map<String, dynamic> json) {
    return new MusicMetadata(
      json['artistName'],
      json['trackName'],
      json['collectionName'],
      json['artworkUrl100']
    );
  }
}