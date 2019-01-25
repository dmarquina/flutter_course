import 'package:flutter/material.dart';
import 'package:flutter_course/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

enum AuthMode { Signup, Login }

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  final Map<String, dynamic> _formData = {'email': null, 'password': null, 'acceptTerms': false};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

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
        controller: _passwordTextController,
        validator: (String value) {
          if (value.isEmpty) {
            return 'La contraseña debe contener como mínimo 5 caracteres';
          }
        },
        onSaved: (String value) {
          _formData['password'] = value;
        });
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Confirmar contraseña', filled: true, fillColor: Colors.white),
      obscureText: true,
      validator: (String value) {
        if (_passwordTextController.text != value) {
          return 'Las contraseñas no son iguales';
        }
      },
      onSaved: (String value) {},
    );
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

  void _submitForm(Function login, Function signup) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    if (!_formData['acceptTerms']) {
      return;
    }
    _formKey.currentState.save();
    if (_authMode == AuthMode.Login) {
      login(_formData['email'], _formData['password']);
    } else {
      final Map<String, dynamic> successInformation =
          await signup(_formData['email'], _formData['password']);
      if (successInformation['success']) {
        Navigator.pushReplacementNamed(context, '/products');
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Ocurrió un error'),
                content: Text(successInformation['message']),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      }
    }
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
                  SizedBox(height: 10.0),
                  _authMode == AuthMode.Signup ? _buildPasswordConfirmTextField() : Container(),
                  _buildAcceptSwitch(),
                  SizedBox(height: 10.0),
                  FlatButton(
                    child:
                        Text('${_authMode == AuthMode.Login ? 'Registrarse' : 'Iniciar sesión'}'),
                    onPressed: () {
                      setState(() {
                        _authMode = _authMode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ScopedModelDescendant<MainModel>(
                    builder: (BuildContext context, Widget child, MainModel model) {
                      return RaisedButton(
                          child: Text('INGRESAR'),
                          textColor: Colors.white,
                          onPressed: () => _submitForm(model.login, model.signup));
                    },
                  )
                ]),
              )),
            ),
          ),
        ));
  }
}
