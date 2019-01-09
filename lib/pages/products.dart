import 'package:flutter/material.dart';

import '../product_manager.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String,dynamic>> products;

  ProductsPage(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                title: Text('Elige mrd'),
                automaticallyImplyLeading: false,
              ),
              ListTile(
                title: Text('Administrar productos'),
                onTap: () => Navigator.pushReplacementNamed(context, '/admin'),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Flutter Course lml'),
        ),
        body: ProductManager(products),
      );
  }
}
