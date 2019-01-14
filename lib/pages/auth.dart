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
          margin: EdgeInsets.all(10.0),
          child: ListView(children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Correo'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (String value) {
                setState(() {
                  _email = value;
                });
              },
            ),
            TextField(
                decoration: InputDecoration(labelText: 'Contraseña'),
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
              title: Text('Aceptar Términos'),
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
          ]),
        ));
  }
}
