import 'package:flutter/material.dart';
import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/scoped-models/products.dart';
import '../pages/product_edit.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatelessWidget {
  Widget _buildEditButton(BuildContext context, int index, ProductsModel model) {
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          model.selectedProductIndex = index;
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
            return ProductEditPage();
          }));
        });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(model.products.elementAt(index).title),
            direction: DismissDirection.endToStart,
            onDismissed: (DismissDirection direction) {
              model.selectedProductIndex = index;
              model.deleteProduct();
            },
            background: Container(
              color: Colors.red,
            ),
            child: Column(children: <Widget>[
              ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(model.products.elementAt(index).image),
                  ),
                  title: Text(model.products.elementAt(index).title),
                  subtitle: Text('S/${model.products.elementAt(index).price.toString()}'),
                  trailing: _buildEditButton(context, index, model)),
              Divider()
            ]),
          );
        },
        itemCount: model.products.length,
      );
    });
  }
}
