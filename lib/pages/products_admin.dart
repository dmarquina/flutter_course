import 'package:flutter/material.dart';
import 'package:flutter_course/pages/product_create.dart';
import 'package:flutter_course/pages/product_list.dart';
import './products.dart';

class ProductsAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              AppBar(
                title: Text('Elige mrd'),
                automaticallyImplyLeading: false,
              ),
              ListTile(
                title: Text('Todos los productos'),
                onTap: () => Navigator.pushReplacementNamed(context, '/'),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Flutter Course lml'),
          bottom: TabBar(tabs: <Widget>[
            Tab(icon: Icon(Icons.create), text: 'Crear producto'),
            Tab(icon: Icon(Icons.list), text: 'Mis productos')
          ]),
        ),
        body: TabBarView(
            children: <Widget>[ProductCreatePage(), ProductListPage()]),
      ),
    );
  }
}
