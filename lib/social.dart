import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Social extends StatefulWidget {
  @override
  _SocialState createState() => _SocialState();
}

class _SocialState extends State<Social> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black12,
      padding: EdgeInsets.only(top: 95),
      child: Column(
        children: <Widget>[
          Text(
            "Nossas Redes",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontFamily: "Roboto",
            ),
          ),
          socialButton("WhatsApp", "https://api.whatsapp.com/send?phone=5579999505505&text=Olá!%20Tudo%20bom?",
              'assets/whatsapp.png',28),
          socialButton(
              "Instagram",
              "https://www.instagram.com/williamlealtamburi/",
              'assets/instagram.png',28),
          socialButton("Facebook", "https://www.facebook.com/williamlealtamburi",
              'assets/facebook.png',28),
          socialButton("Twitter", "https://twitter.com/williamleal",
              'assets/twitter.png',30),
          socialButton("YouTube", "https://www.youtube.com/williamleal",
              'assets/youtube.png',28),
        ],
      ),
    );
  }
}

Widget socialButton(String nameSocial, String linkSocial, String iconSocial, double size) {
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 25, left: 15),
        child:
        InkWell(
          child: Image(
            image: AssetImage(iconSocial),
            height: size,
          ),
          onTap: () async {
            await launch(linkSocial);
          },
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 25, left: 5),
        child: InkWell(
          child: Text(
            nameSocial,
            style: TextStyle(fontSize: 20),
          ),
          onTap: () async {
            await launch(linkSocial);
          },
        ),
      )
    ],
  );
}
