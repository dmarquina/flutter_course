import 'package:flutter/material.dart';

import '../models/product.dart';
import '../pages/product_edit.dart';
import '../pages/product_list.dart';

class ProductsAdminPage extends StatelessWidget {

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Elige mrd'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Todos los productos'),
            onTap: () => Navigator.pushReplacementNamed(context, '/products'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('Flutter Course lml'),
          bottom: TabBar(tabs: <Widget>[
            Tab(icon: Icon(Icons.create), text: 'Crear producto'),
            Tab(icon: Icon(Icons.list), text: 'Mis productos')
          ]),
        ),
        body: TabBarView(children: <Widget>[
          ProductEditPage(),
          ProductListPage()
        ]),
      ),
    );
  }
}
