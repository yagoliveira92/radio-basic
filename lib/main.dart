import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:radiobasic/controllers/cover-controller.dart';
import 'package:radiobasic/controllers/player.dart';
import 'package:radiobasic/pages/home.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  GetIt getIt = GetIt.I;
  getIt.registerLazySingleton<CoverController>(() => CoverController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Radio Basic';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Color(0xFFF6C33A),
      title: _title,
      home: AudioServiceWidget(child: MyStatefulWidget()),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  var player = Player();
  @override
  void initState() {
    player.initPlaying();
    super.initState();
  }

  Widget build(BuildContext context) {
    return _introScreen();
  }
}

Widget _introScreen() {
  return Stack(
    children: <Widget>[
      SplashScreen(
        seconds: 2,
        backgroundColor: Colors.white,
        navigateAfterSeconds: Home(),
        loaderColor: Colors.transparent,
      ),
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              heightFactor: 2.1,
              child: Image.asset(
                'assets/logo_igreja.png',
                height: 300,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
