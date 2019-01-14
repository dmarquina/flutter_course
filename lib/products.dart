import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products(this.products);

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(products[index]['image']),
          Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      products[index]['title'],
                      style: TextStyle(
                          fontSize: 26.0, fontWeight: FontWeight.bold, fontFamily: 'Oswald'),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(5.0)),
                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                    child: Text(
                      'S/${products[index]['price'].toString()}',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Oswald',
                          color: Colors.white),
                    ),
                  ),
                ],
              )),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(4.0)),
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
              child: Text('Calle Buenos Aires, Stone Bridge')),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Detalle'),
                onPressed: () => Navigator.pushNamed<bool>(context, '/product/' + index.toString()),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return products.length > 0
        ? ListView.builder(itemBuilder: _buildProductItem, itemCount: products.length)
        : Center(
            child: Text('No hay productos, agrega uno amiguito :)'),
          );
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }
}
