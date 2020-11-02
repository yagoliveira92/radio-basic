import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_basic/app/core/injection_container.dart';
import 'package:radio_basic/app/features/cover_album/presentation/cubit/cover_album_cubit.dart';
import 'package:radio_basic/app/features/cover_album/presentation/widgets/cover_album_notfound_widget.dart';
import 'package:radio_basic/app/features/cover_album/presentation/widgets/cover_album_widget.dart';

class CoverAlbumScreen extends StatelessWidget {
  const CoverAlbumScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xFF1B203C),
          image: DecorationImage(
              image: ExactAssetImage('assets/background.jpg'),
              fit: BoxFit.cover)),
      child: Padding(
        padding: EdgeInsets.only(bottom: 80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Image.asset(
                'package/assets/abc_logo.png',
                height: 120,
                scale: 2,
              ),
            ),
            BlocProvider(
              create: (_) => dependencia<CoverAlbumCubit>(),
              child: BlocConsumer(
                listener: null,
                builder: (context, state) {
                  if (state is CoverAlbumInitial || state is CoverAlbumNotFound) {
                    return CoverAlbumNotFoundWidget();
                  }
                    return CoverAlbumWidget(musicMetadata: ,);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
