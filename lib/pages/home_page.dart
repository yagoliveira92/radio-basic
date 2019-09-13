import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF1B203C),
        image: DecorationImage(
          image: ExactAssetImage('assets/background.jpg'),
          fit: BoxFit.cover
        )
      ),
      child: Column(
        children: <Widget>[
          Center(
            heightFactor: 5,
            child: Image.asset('assets/logo.png', scale: 2,),
          ),
        ],
      ),
    );
  }
}
