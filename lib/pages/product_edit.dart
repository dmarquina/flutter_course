import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:flutter_course/widgets/helpers/ensure-visible.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Product product;
  final int productIndex;

  ProductEditPage({this.addProduct, this.updateProduct, this.product, this.productIndex});

  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  Widget _buildTitleTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
          focusNode: _titleFocusNode,
          decoration: InputDecoration(labelText: 'Nombre'),
          initialValue: widget.product != null ? widget.product.title : '',
          validator: (String value) {
            if (value.isEmpty || value.length < 5) {
              return 'Tìtulo requerido y debe tener 5+ caracteres';
            }
          },
          onSaved: (String value) {
            _formData['title'] = value;
          }),
    );
  }

  Widget _buildDescriptionTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
          focusNode: _descriptionFocusNode,
          decoration: InputDecoration(labelText: 'Descripción'),
          initialValue: widget.product != null ? widget.product.description : '',
          validator: (String value) {
            if (value.isEmpty || value.length < 10) {
              return 'Descripción requerida y debe tener 5+ caracteres';
            }
          },
          maxLines: 4,
          onSaved: (String value) {
            _formData['description'] = value;
          }),
    );
  }

  Widget _buildPriceTextField() {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
          focusNode: _priceFocusNode,
          decoration: InputDecoration(labelText: 'Precio'),
          initialValue: widget.product != null ? widget.product.price.toString() : '',
          validator: (String value) {
            if (value.isEmpty || !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
              return 'Precio requerido y debe ser un número';
            }
          },
          keyboardType: TextInputType.number,
          onSaved: (String value) {
            _formData['price'] = double.parse(value);
          }),
    );
  }

  Widget _buildPageContent(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: targetPadding / 2,
            ),
            children: <Widget>[
              _buildTitleTextField(),
              _buildDescriptionTextField(),
              _buildPriceTextField(),
              SizedBox(
                height: 10.0,
              ),
              RaisedButton(child: Text('Guardar'), textColor: Colors.white, onPressed: _submitForm)
            ],
          ),
        ),
      ),
    );
  }

  _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (widget.product != null) {
      widget.updateProduct(
          widget.productIndex,
          Product(
              title: _formData['title'],
              description: _formData['description'],
              price: _formData['price'],
              image: _formData['image']));
    } else {
      widget.addProduct(Product(
          title: _formData['title'],
          description: _formData['description'],
          price: _formData['price'],
          image: _formData['image']));
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final Widget pageContent = _buildPageContent(context);

    return widget.product != null
        ? Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: pageContent,
          )
        : pageContent;
  }
}
