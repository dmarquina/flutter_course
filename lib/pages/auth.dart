import 'package:flutter/material.dart';
import './products.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _email;
  String _password;
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido'),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  image: AssetImage('assets/background.jpg'))),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Correo',filled: true, fillColor: Colors.white),
                keyboardType: TextInputType.emailAddress,
                onChanged: (String value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(height:10.0),
              TextField(
                  decoration: InputDecoration(labelText: 'Contraseña',filled: true, fillColor: Colors.white),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      _password = value;
                    });
                  }),
              SwitchListTile(
                value: _acceptTerms,
                onChanged: (bool value) {
                  setState(() {
                    _acceptTerms = value;
                  });
                },
                title: Text('Aceptar Términos', ),
              ),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(
                  child: Text('INGRESAR'),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/products');
                  }),
            ])),
          ),
        ));
  }
}
