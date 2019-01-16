import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {'email': null, 'password': null, 'acceptTerms': false};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.15), BlendMode.dstATop),
        image: AssetImage('assets/background.jpg'));
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Correo', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'El correo ingresado no cumple el formato ';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
        decoration: InputDecoration(labelText: 'Contraseña', filled: true, fillColor: Colors.white),
        obscureText: true,
        validator: (String value) {
          if (value.isEmpty) {
            return 'La contraseña debe contener como mínimo 5 caracteres';
          }
        },
        onSaved: (String value) {
          _formData['password'] = value;
        });
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
      title: Text(
        'Aceptar Términos',
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    if (!_formData['acceptTerms']) {
      return;
    }
    _formKey.currentState.save();
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;

    return Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido'),
        ),
        body: Container(
          decoration: BoxDecoration(image: _buildBackgroundImage()),
          padding: EdgeInsets.all(10.0),
          child: Container(
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: Container(
                width: targetWidth,
                child: Column(children: <Widget>[
                  _buildEmailTextField(),
                  SizedBox(height: 10.0),
                  _buildPasswordTextField(),
                  _buildAcceptSwitch(),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                      child: Text('INGRESAR'), textColor: Colors.white, onPressed: _submitForm),
                ]),
              )),
            ),
          ),
        ));
  }
}
