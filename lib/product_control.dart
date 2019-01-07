import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function addProducts;

  ProductControl(this.addProducts);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Añadir producto'),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () {
        addProducts({'title': 'Chocolate', 'image': 'assets/food.jpg'});
      },
      elevation: 2.0,
    );
  }
}
