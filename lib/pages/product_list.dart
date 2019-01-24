import 'package:flutter/material.dart';
import 'package:flutter_course/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

import '../pages/product_edit.dart';

class ProductListPage extends StatefulWidget {
  final MainModel model;

  ProductListPage(this.model);

  @override
  ProductListPageState createState() {
    return new ProductListPageState();
  }
}

class ProductListPageState extends State<ProductListPage> {
  @override
  initState(){
    widget.model.fetchProducts();
    super.initState();
  }

  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          model.selectProduct(index);
//          model.selectProduct(model.allProducts[index].id);
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
            return ProductEditPage();
          })).then((_) => model.selectProduct(null) );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(model.allProducts.elementAt(index).title),
            direction: DismissDirection.endToStart,
            onDismissed: (DismissDirection direction) {
              model.selectProduct(index);
              model.deleteProduct();
            },
            background: Container(
              color: Colors.red,
            ),
            child: Column(children: <Widget>[
              ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(model.allProducts.elementAt(index).image),
                  ),
                  title: Text(model.allProducts.elementAt(index).title),
                  subtitle: Text('S/${model.allProducts.elementAt(index).price.toString()}'),
                  trailing: _buildEditButton(context, index, model)),
              Divider()
            ]),
          );
        },
        itemCount: model.allProducts.length,
      );
    });
  }
}
