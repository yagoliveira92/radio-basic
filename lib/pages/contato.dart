import 'package:flutter/material.dart';

class Contato extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Center(
              heightFactor: 1.2,
              child: Column(
                children: <Widget>[
                  Text(
                    'Igreja em Aracaju',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text('Todos os Direitos Reservados',
                      style: TextStyle(fontSize: 18)),
                  Text('Versão 1.0.0', style: TextStyle(fontSize: 18)),
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 30),
                    child: CustomPaint(
                      painter: Drawhorizontalline(),
                    ),
                  ),
                  Image.asset(
                    'assets/abc_logo.png',
                    width: 150,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Desenvolvido por',
                          style: TextStyle(fontSize: 18),
                        ),
                        Padding(padding: EdgeInsets.only(top: 12), child: Image.asset('assets/logo_tecnocamp.png', height: 50,)),
                      ],
                    ),
                  )
                ],
              ))
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
