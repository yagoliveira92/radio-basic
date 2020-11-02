import 'package:flutter/material.dart';
import 'package:radiobasic/controllers/email.dart';

class PedidoMusica extends StatefulWidget {
  PedidoMusica({Key key}) : super(key: key);

  @override
  _PedidoMusicaState createState() => _PedidoMusicaState();
}

class _PedidoMusicaState extends State<PedidoMusica> {
  static GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // var email = Email();
  int loading = 0;

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final artistaController = TextEditingController();
  final musicaController = TextEditingController();
  final mensagemController = TextEditingController();

  // Future<void> _enviarEmail() async {
  //   setState(() {
  //     loading = 1;
  //   });
  //   bool result = await email.sendMessage(
  //       "A ouvinte " +
  //           nomeController.text +
  //           " pediu a música " +
  //           musicaController.text +
  //           " e deixou a seguinte mensagem: " +
  //           mensagemController.text,
  //       'radio@igrejaemaracaju.com.br',
  //       "Pedido de música da " + nomeController.text);

  //   if (result) {
  //     _scaffoldKey.currentState.showSnackBar(SnackBar(
  //       content: Text('Mensagem Enviada com Sucesso!'),
  //     ));
  //     limparFormulario();
  //     setState(() {
  //       loading = 2;
  //     });
  //     Timer(Duration(milliseconds: 3300), () {
  //       setState(() {
  //         loading = 0;
  //       });
  //     });
  //   } else {
  //     _scaffoldKey.currentState.showSnackBar(SnackBar(
  //       content: Text('Erro ao enviar mensagem'),
  //     ));
  //     setState(() {
  //       loading = 0;
  //     });
  //   }
  // }

  void limparFormulario() {
    nomeController.clear();
    emailController.clear();
    artistaController.clear();
    musicaController.clear();
    mensagemController.clear();
  }

  Widget setUpButtonChild() {
    if (loading == 0) {
      return Text(
        "Enviar",
        style: TextStyle(fontSize: 18),
      );
    } else if (loading == 1) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
        ),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Pedido de Música'),
        centerTitle: true,
        backgroundColor: Color(0xFFE47833),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Image.asset('assets/abc_logo.png'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: TextFormField(
                    autofocus: true,
                    controller: nomeController,
                    decoration: InputDecoration(
                        labelText: "Nome", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Campo é obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: TextFormField(
                    autofocus: true,
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: "Email", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Campo é obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: TextFormField(
                    autofocus: true,
                    controller: artistaController,
                    decoration: InputDecoration(
                        labelText: "Artista", border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: TextFormField(
                    autofocus: true,
                    controller: musicaController,
                    decoration: InputDecoration(
                        labelText: "Música", border: OutlineInputBorder()),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Campo é obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: TextFormField(
                    autofocus: true,
                    controller: mensagemController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: InputDecoration(
                        labelText: "Mensagem",
                        alignLabelWithHint: true,
                        border: OutlineInputBorder()),
                  ),
                ),
                RaisedButton(
                  color: Color(0xFFE47833),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Color(0xFFE47833))),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // _enviarEmail();
                    }
                  },
                  child: setUpButtonChild(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
