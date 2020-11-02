import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:radiobasic/controllers/cover-controller.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final controller = GetIt.I.get<CoverController>();

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      controller.getMetadata();
    });
    super.initState();
  }

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
                  'assets/abc_logo.png',
                  height: 120,
                  scale: 2,
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.transparent,
                height: 320,
                child: Observer(
                  builder: (_) {
                    return Column(
                      children: <Widget>[
                        ClipOval(
                          child: Image.network(
                            controller.coverAlbum,
                            height: 230,
                          ),
                        ),
                        Padding(
                          child: Text(
                            controller.musicName,
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
                            controller.artistName,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          padding: EdgeInsets.only(top: 10),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
