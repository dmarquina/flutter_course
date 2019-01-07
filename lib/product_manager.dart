import 'package:flutter/material.dart';
import 'package:flutter_course/product_control.dart';
import './products.dart';

class ProductManager extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function addProduct;
  final Function deleteProduct;

  ProductManager(this.products, this.addProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ProductControl(addProduct),
        Expanded(child: Products(products, deleteProduct: deleteProduct)),
      ],
    );
  }
}
