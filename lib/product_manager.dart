import 'package:flutter/material.dart';
import './products.dart';

class ProductManager extends StatefulWidget {
  final String startingProducts;
  Function addProducts;

  ProductManager({this.startingProducts, this.addProducts});

  @override
  _ProductManagerState createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {
  List<String> _products = [];

  @override
  void initState() {
    super.initState();
    widget.addProducts = _addProducts;
    if(widget.startingProducts != null){
      _products.add(widget.startingProducts);
    }
  }

  void _addProducts(String product) {
    setState(() {
      _products.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: Products(_products)),
      ],
    );
  }
}
