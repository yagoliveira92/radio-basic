part of 'cover_album_cubit.dart';

@immutable
abstract class CoverAlbumState {}

class CoverAlbumInitial extends CoverAlbumState {}

class CoverAlbumUpdate extends CoverAlbumState {}

class CoverAlbumNotFound extends CoverAlbumState {}
