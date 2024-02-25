import 'package:cart_scope/src/constants/test_products.dart';
import 'package:cart_scope/src/features/products/data/fake_product_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final fakeProductRepository = FakeProductRepository();
  // Using test() function
  // tesT(Descreption of testing process, ()=> expect(
  // first we type the actual value we want to check,
  // then we type the value we expect from testing actual one
  // ))
  test(
    'Test products list that returned from getProductsList',
    () => expect(
      fakeProductRepository.getProductList(),
      kTestProducts,
    ),
  );
}
