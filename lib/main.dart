import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './product_manager.dart';
import './product_control.dart';

void main() {
//  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Widget productManager = ProductManager();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Course lml'),
        ),
        body: productManager,
        floatingActionButton: ProductControl(productManager),
      ),
    );
  }
}
