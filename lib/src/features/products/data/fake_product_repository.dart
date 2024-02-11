import 'package:cart_scope/src/constants/test_products.dart';
import 'package:cart_scope/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductRepository {
  FakeProductRepository();
  // Singelton .. we force any one uses the class to use the single object called 'instance'
  // static FakeProductRepository instance = FakeProductRepository._();
  final _products = kTestProducts;

  List<Product> getProductList() {
    return _products;
  }

  Product? getProduct(String productID) {
    return _products.firstWhere((product) => product.id == productID);
  }

  Future<List<Product>> fetchProcutList() async {
    // await Future.delayed(const Duration(seconds: 3));
    return Future.value(_products);
  }

  Stream<List<Product>> watchProcustList() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield _products;
  }

  Stream<Product?> watchProduct(String productID) {
    return watchProcustList()
        .map((products) => products.firstWhere((product) => product.id == productID));
  }
}

final productRepositoryProvider = Provider<FakeProductRepository>((ref) {
  return FakeProductRepository();
});

final productListStreamProvider = StreamProvider<List<Product>>((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  return productRepository.watchProcustList();
});

final productListFutureProvider = FutureProvider<List<Product>>((ref) async {
  final productRepository = ref.watch(productRepositoryProvider);
  return productRepository.fetchProcutList();
});

final productProvider = StreamProvider.family<Product?, String>((ref, productID) {
  final productRepository = ref.watch(productRepositoryProvider);
  return productRepository.watchProduct(productID);
});
