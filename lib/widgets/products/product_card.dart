import 'package:flutter/material.dart';
import 'package:flutter_course/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/product.dart';
import '../../widgets/products/address_tag.dart';
import '../../widgets/ui_elements/title_default.dart';
import '../../widgets/products/price_tag.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  Widget _buildTitlePriceRow() {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(child: TitleDefault(product.title)),
            SizedBox(
              width: 8.0,
            ),
            PriceTag(product.price.toString()),
          ],
        ));
  }

  Widget _buildActionButtons(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.info_outline, color: Theme.of(context).primaryColor),
              onPressed: () =>
                  Navigator.pushNamed<bool>(context, '/product/' + model.allProducts[productIndex].id),
            ),
            IconButton(
              icon: Icon(
                model.allProducts[productIndex].isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                model.selectProduct(model.allProducts[productIndex].id);
                model.toggleProductFavoriteStatus();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Column(
        children: <Widget>[
          FadeInImage(
            image: NetworkImage(product.image),
            height: 300.0,
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/image-loader.gif'),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              children: <Widget>[
                _buildTitlePriceRow(),
                AddressTag('Calle Buenos Aires, Stone Bridge'),
                Text(product.userEmail),
                _buildActionButtons(context),
              ],
            ),
          )
        ],
      ),
    );
  }
}
