import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black12,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 80, bottom: 12),
            child: Image(
              image: AssetImage('assets/logo.png'),
              height: 80,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Column(
              children: <Widget>[
                Text(
                  "Rua Rosário, 425",
                  style: TextStyle(fontSize: 15, fontFamily: "Roboto"),
                ),
                Text(
                  "Santo Antônio, Aracaju/SE",
                  style: TextStyle(fontSize: 15, fontFamily: "Roboto"),
                ),
                InkWell(
                  child: Text(
                    "(79 99950-5505 / 79 3322-2233)",
                    style: TextStyle(fontSize: 15, fontFamily: "Roboto"),
                  ),
                  onTap: () async {
                    await launch("tel:+5579999505505");
                  },
                ),
                InkWell(
                  child: Text(
                    "contato@abcradio.com.br",
                    style: TextStyle(fontSize: 15, fontFamily: "Roboto"),
                  ),
                  onTap: () async {
                    await launch("mailto:contato@abcradio.com.br");
                  },
                ),
              ],
            ),
          ),
          InkWell(
            child: Image(
              image: AssetImage('assets/mapa.png'),
              height: 280,
            ),
            onTap: () async {
              await launch("https://goo.gl/maps/5papiLgdr8T2");
            },
          )
        ],
      ),
    );
  }
}
