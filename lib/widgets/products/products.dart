import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../widgets/products/product_card.dart';

class Products extends StatelessWidget {
  final List<Product> products;

  Products(this.products);

  Widget _buildProductList() {
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
    return _buildProductList();
  }
}
