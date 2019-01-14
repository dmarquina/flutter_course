import 'package:flutter/material.dart';
import '../../widgets/products/address_tag.dart';
import '../../widgets/ui_elements/title_default.dart';
import '../../widgets/products/price_tag.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  Widget _buildTitlePriceRow(){
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
                child: TitleDefault(product['title'])
            ),
            SizedBox(
              width: 8.0,
            ),
            PriceTag(product['price'].toString()),
          ],
        ));
  }
  
  Widget _buildAcctionButtons(BuildContext context){
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info_outline, color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.pushNamed<bool>(context, '/product/' + productIndex.toString()),
        ),
        IconButton(
          icon: Icon(
            Icons.favorite_border,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {},
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Column(
        children: <Widget>[
          Image.asset(product['image']),
          _buildTitlePriceRow(),
          AddressTag('Calle Buenos Aires, Stone Bridge'),
          _buildAcctionButtons(context)
          
        ],
      ),
    );
  }
}
