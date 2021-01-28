import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:radio_basic/app/features/cover_album/domain/entities/music_metadata_entity.dart';

part 'cover_album_state.dart';

class CoverAlbumCubit extends Cubit<CoverAlbumState> {
  CoverAlbumCubit() : super(CoverAlbumInitial());
}
