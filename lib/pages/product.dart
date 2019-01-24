import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_course/scoped-models/main.dart';

import '../models/product.dart';
import '../widgets/products/address_tag.dart';
import '../widgets/products/price_tag.dart';
import '../widgets/ui_elements/title_default.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductPage extends StatelessWidget {
  final int productIndex;

  ProductPage(this.productIndex);

  Widget _buildTitlePriceRow(String title,String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Expanded(child: TitleDefault(title)),
        SizedBox(
          width: 8.0,
        ),
        PriceTag(price),
        SizedBox(
          width: 8.0,
        ),
      ],
    );
  }

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('¿Estas seguro?'),
            content: Text('Esta accón es permanente'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('SI'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              final Product product = model.allProducts.elementAt(productIndex);
              return Scaffold(
                appBar: AppBar(
                  title: Text(product.title),
                ),
                body: Center(
                  child: Column(
                    children: <Widget>[
                      Image.network(product.image),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                          child: _buildTitlePriceRow(product.title, product.price.toString())),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                        child: AddressTag('Calle Buenos Aires, Stone Bridge'),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                        child: Text(product.description),
                        alignment: Alignment(-1.0, 0.0),
                      ),
                      Container(
                        alignment: Alignment(1.0, 0.0),
                        child: IconButton(
                          icon: Icon(Icons.delete_forever),
                          color: Colors.red,
                          iconSize: 30.0,
                          onPressed: () => _showWarningDialog(context),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
