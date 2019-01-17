import '../models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsModel extends Model {
  List<Product> _products = [];
  int selectedProductIndex;

  List<Product> get products => List.from(_products);

  void addProduct(Product product) {
    _products.add(product);
    selectedProductIndex = null;
  }

  void updateProduct(Product product) {
    _products[selectedProductIndex] = product;
    selectedProductIndex = null;
  }

  void deleteProduct() {
    _products.removeAt(selectedProductIndex);
    selectedProductIndex = null;
  }

  Product get selectedProduct {
    if (selectedProductIndex != null) {
      return _products[selectedProductIndex];
    } else {
      return null;
    }
  }
}
