import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppSate();
  }
}

class _MyAppSate extends State<MyApp> {
  List<String> _products = ['Food Tester', 'Drink Tester'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Course lml'),
          ),
          body: Column(children: [
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(onPressed: () {
                setState(() {
                  _products.add('Wine Tester');
                });
              }, child: Text('Añadir Producto')),
            ),
            Column(
                children: _products
                    .map((element) => Card(
                          child: Column(
                            children: <Widget>[
                              Image.asset('assets/food.jpg'),
                              Text(element)
                            ],
                          ),
                        ))
                    .toList(),
            )
          ])),
    );
  }
}