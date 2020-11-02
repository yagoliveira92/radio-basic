import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cover_album_state.dart';

class CoverAlbumCubit extends Cubit<CoverAlbumState> {
  CoverAlbumCubit() : super(CoverAlbumInitial());
}
