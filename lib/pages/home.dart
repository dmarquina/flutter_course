import 'package:flutter/material.dart';
import '../product_manager.dart';
import '../product_control.dart';


class HomePage extends StatelessWidget {
  final Widget productManager = ProductManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Course lml'),
      ),
      body: productManager,
      floatingActionButton: ProductControl(productManager),
    );
  }
}
