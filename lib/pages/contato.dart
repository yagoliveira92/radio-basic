import 'package:flutter/material.dart';
import 'package:radiobasic/assets/redes_sociais_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class Contato extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xFF1B203C),
          image: DecorationImage(
              image: ExactAssetImage('assets/background.jpg'),
              fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/abc_logo.png',
            width: 150,
          ),
          Padding(
            padding: EdgeInsets.only(top: 25, bottom: 10),
            child: Image.asset(
              'assets/mapa.png',
              height: 230,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: (screenSize.width / 5.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ABC Rádio',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Rua Mirosmar Ferreira Dantas',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                  Text(
                    'Aracaju, Sergipe - SE, 49052-879',
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    RedesSociais.instagram,
                    color: Colors.white,
                    size: 35,
                  ),
                  onPressed: () {
                    launch(
                      "https://instagram.com/abcaudio",
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    RedesSociais.facebook,
                    color: Colors.white,
                    size: 35,
                  ),
                  onPressed: () {
                    launch(
                      "https://facebook.com/abcaudio",
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    RedesSociais.youtube,
                    color: Colors.white,
                    size: 35,
                  ),
                  onPressed: () {
                    launch(
                      "https://youtube.com/abcaudio",
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: (screenSize.height / 7)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Desenvolvido por',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Image.asset(
                        'assets/logo_tecnocamp.png',
                        height: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 100),
                Column(
                  children: <Widget>[
                    Text(
                      'Stream by',
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Image.asset(
                          'assets/abc_branco.png',
                          height: 30,
                        )),
                  ],
                ),
                SizedBox(width: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Drawhorizontalline extends CustomPainter {
  Paint _paint;

  Drawhorizontalline() {
    _paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(-180, 0), Offset(180, 0), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
