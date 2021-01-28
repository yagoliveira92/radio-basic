import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_basic/app/core/injection_container.dart';
import 'package:radio_basic/app/features/contact/presentation/pages/contact_screen.dart';
import 'package:radio_basic/app/features/cover_album/presentation/pages/cover_album_screen.dart';
import 'package:radio_basic/app/features/home_page/presentation/cubit/home_page_cubit.dart';
import 'package:radio_basic/app/features/home_page/presentation/widgets/bottombar_widget.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return AudioServiceWidget(
      child: WillPopScope(
        onWillPop: () => alertExit(context: context, playPause: () {}),
        child: BlocProvider<HomePageCubit>(
          create: (_) => dependencia<HomePageCubit>(),
          child: Scaffold(
            extendBody: true,
            body: BlocConsumer(
              listener: (context, state) {
                if (state is HomePageContact) {
                  return ContactScreen();
                }
                if (state is HomePageCoverAlbum) {
                  return CoverAlbumScreen();
                }
              },
              builder: (context, state) {
                return Container();
              },
            ),
            bottomNavigationBar: BlocConsumer<HomePageCubit, HomePageState>(
              listener: (context, state) {},
              builder: (context, state) {
                return BottomAppBar(
                  color: Colors.green,
                  shape: const CircularNotchedRectangle(),
                  notchMargin: 5,
                  child: BottomAppbarWidget(
                    changePage: () =>
                        context.bloc<HomePageCubit>().changePage,
                  ),
                );
              },
            ),
            floatingActionButton: StreamBuilder<PlaybackState>(
                stream: AudioService.playbackStateStream,
                builder: (context, snapshot) {
                  return Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      height: 100,
                      width: 100,
                      child: FittedBox(
                        child: buildPlayer(),
                      ));
                }),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          ),
        ),
      ),
    );
  }

  Future<bool> alertExit({BuildContext context, VoidCallback playPause}) {
    return showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Tem certeza que deseja sair?'),
            content: Text('O aplicativo será fechado'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Não'),
              ),
              FlatButton(
                onPressed: playPause,
                child: Text('Sim'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
