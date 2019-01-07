import 'package:flutter/material.dart';
import './products.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Page'),
        ),
        body: Center(
          child: RaisedButton(
              child: Text('Login'),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              }),)
    );
  }
}
