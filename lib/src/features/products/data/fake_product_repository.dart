import 'dart:async';
import 'package:cart_scope/src/constants/test_products.dart';
import 'package:cart_scope/src/features/products/domain/product.dart';
import 'package:cart_scope/src/utils/delay.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductRepository {
  FakeProductRepository({this.isDelayed = false});
  // Singelton .. we force any one uses the class to use the single object called 'instance'
  // static FakeProductRepository instance = FakeProductRepository._();
  final _products = kTestProducts;
  final bool isDelayed;

  List<Product> getProductList() {
    return _products;
  }

  Product? getProduct(String productID) {
    return _getProduct(_products, productID);
  }

  Future<List<Product>> fetchProcutList() async {
    await delay(isDelayed);
    return Future.value(_products);
  }

  Stream<List<Product>> watchProcustList() async* {
    await delay(isDelayed);
    yield _products;
  }

  Stream<Product?> watchProduct(String productID) {
    return watchProcustList().map((products) => _getProduct(products, productID));
  }

  static Product? _getProduct(List<Product> products, String productID) {
    try {
      return products.firstWhere((product) => product.id == productID);
    } catch (e) {
      return null;
    }
  }
}

final productRepositoryProvider = Provider<FakeProductRepository>((ref) {
  return FakeProductRepository();
});

final productListStreamProvider = StreamProvider.autoDispose<List<Product>>((ref) {
  // debugPrint('Created product list Provider');
  final productRepository = ref.watch(productRepositoryProvider);
  ref.keepAlive();
  // ref.onDispose(() => debugPrint('Product list provider disposed'));
  return productRepository.watchProcustList();
});

final productListFutureProvider = FutureProvider<List<Product>>((ref) async {
  final productRepository = ref.watch(productRepositoryProvider);
  return productRepository.fetchProcutList();
});

final productProvider = StreamProvider.autoDispose.family<Product?, String>((ref, productID) {
  // debugPrint('Created product Provider with id $productID');
  final productRepository = ref.watch(productRepositoryProvider);
  // final link = ref.keepAlive();
  // Timer(const Duration(seconds: 10), () {
  //   link.close();
  // });
  // ref.onDispose(() => debugPrint('Product provider disposed with id $productID'));
  return productRepository.watchProduct(productID);
});
