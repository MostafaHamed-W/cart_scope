import 'package:cart_scope/src/constants/test_products.dart';
import 'package:cart_scope/src/features/products/domain/product.dart';

class FakeProductRepository {
  FakeProductRepository._();
  // Singelton .. we force any one uses the class to use the single object called 'instance'
  static FakeProductRepository instance = FakeProductRepository._();

  List<Product> getProductsList() {
    return kTestProducts;
  }

  Product? getProduct(String productID) {
    return kTestProducts.firstWhere((product) => product.id == productID);
  }
}
