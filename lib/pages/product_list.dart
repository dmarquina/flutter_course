import 'package:flutter/material.dart';
import 'package:flutter_course/models/product.dart';
import '../pages/product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Product> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
            return ProductEditPage(
              product: products.elementAt(index),
              updateProduct: updateProduct,
              productIndex: index,
            );
          }));
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: Key(products.elementAt(index).title),
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection direction) {
            deleteProduct(index);
          },
          background: Container(
            color: Colors.red,
          ),
          child: Column(children: <Widget>[
            ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(products.elementAt(index).image),
                ),
                title: Text(products.elementAt(index).title),
                subtitle: Text('S/${products.elementAt(index).price.toString()}'),
                trailing: _buildEditButton(context, index)
            ),
            Divider()
          ]),
        );
      },
      itemCount: products.length,
    );
  }
}
