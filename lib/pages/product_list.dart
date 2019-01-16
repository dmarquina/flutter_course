import 'package:flutter/material.dart';
import '../pages/product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
            return ProductEditPage(
              product: products[index],
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
          key: Key(products[index]['title']),
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
                  backgroundImage: AssetImage(products[index]['image']),
                ),
                title: Text(products[index]['title']),
                subtitle: Text('S/${products[index]['price'].toString()}'),
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
