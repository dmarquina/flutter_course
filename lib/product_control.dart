import 'package:flutter/material.dart';
import 'package:flutter_course/product_manager.dart';

class ProductControl extends StatelessWidget {
  final ProductManager productManager;

  ProductControl(this.productManager);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          productManager.addProducts('holi');
        },
        child: Icon(Icons.add),
      elevation: 2.0,
    );
  }
}
