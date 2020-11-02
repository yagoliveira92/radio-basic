import 'package:flutter/material.dart';
import 'package:radio_basic/app/core/fonts/redes_sociais_icons.dart';

class BottomAppbarWidget extends StatelessWidget {
  const BottomAppbarWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
              height: 70,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          RedesSociais.icn_radio_white,
                          color: Color(0xFF1B203C),
                          size: 35,
                        ),
                        onPressed: () {
                          setState(() {
                            _myPage.jumpToPage(0);
                          });
                        },
                      ),
                      Text(
                        "Rádio",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(RedesSociais.icn_whts,
                            color: Color(0xFF1B203C), size: 35),
                        onPressed: () {
                          launch(
                            "https://api.whatsapp.com/send?phone=5579981558855&text=Opa!%20Quero%20pedir%20uma%20m%C3%BAsica!",
                          );
                        },
                      ),
                      Text(
                        "Whatsapp",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 110,
                  ),
                  Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          RedesSociais.g24,
                          color: Color(0xFF1B203C),
                          size: 35,
                        ),
                        onPressed: () {
                          setState(() {
                            _myPage.jumpToPage(1);
                          });
                        },
                      ),
                      Text(
                        "Redes",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          RedesSociais.icn_cmprt,
                          color: Color(0xFF1B203C),
                          size: 35,
                        ),
                        onPressed: () {
                          Share.share(
                              '''Ouça a rádio que trás o melhor do flashback: 
https://play.google.com/store/apps/details?id=br.abcradio.web''');
                        },
                      ),
                      Text(
                        "Compartilhe",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  )
                ],
              ),
            ),
  }
}