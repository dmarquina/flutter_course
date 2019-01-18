import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/product.dart';
import '../../scoped-models/main.dart';
import '../../widgets/products/product_card.dart';

class Products extends StatelessWidget {

  Widget _buildProductList(List<Product> products) {
    return products.length > 0
        ? ListView.builder(
            itemBuilder: (BuildContext context, int index) => ProductCard(products[index], index),
            itemCount: products.length)
        : Center(
            child: Text('No hay productos, agrega uno amiguito :)'),
          );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      return _buildProductList(model.displayedProducts);
    });
  }
}
