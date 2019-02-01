import 'package:flutter/material.dart';
import 'package:flutter_course/widgets/ui_elements/logout_list_tile.dart';

import '../pages/product_edit.dart';
import '../pages/product_list.dart';
import '../scoped-models/main.dart';

class ProductsAdminPage extends StatelessWidget {
  final MainModel model;

  ProductsAdminPage(this.model);

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
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          Divider(),
          LogoutListTile(),
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
        body: TabBarView(children: <Widget>[ProductEditPage(), ProductListPage(model)]),
      ),
    );
  }
}
