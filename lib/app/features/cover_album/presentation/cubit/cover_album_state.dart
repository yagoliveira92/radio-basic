part of 'cover_album_cubit.dart';

@immutable
abstract class CoverAlbumState {}

class CoverAlbumInitial extends CoverAlbumState {}

class CoverAlbumUpdate extends CoverAlbumState {
  CoverAlbumUpdate(this.musicMetadata);

  final MusicMetadataEntity musicMetadata;
}

class CoverAlbumNotFound extends CoverAlbumState {}
