import 'package:flutter/material.dart';

class CoverAlbumNotFoundWidget extends StatelessWidget {
  const CoverAlbumNotFoundWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      height: 320,
      child: Column(
        children: <Widget>[
          ClipOval(child: Image.asset('noimageavailable.jpg')),
          Padding(
            child: Text(
              "ABC Rádio",
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
              "A rádio que não cansa você!",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.only(top: 10),
          )
        ],
      ),
    );
  }
}
