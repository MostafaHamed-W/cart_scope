import 'dart:async';

import 'package:cart_scope/src/constants/test_products.dart';
import 'package:cart_scope/src/features/products/domain/product.dart';
import 'package:flutter/foundation.dart';
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

final productListStreamProvider = StreamProvider.autoDispose<List<Product>>((ref) {
  debugPrint('Created product list Provider');
  final productRepository = ref.watch(productRepositoryProvider);
  ref.keepAlive();
  ref.onDispose(() => debugPrint('Product list provider disposed'));
  return productRepository.watchProcustList();
});

final productListFutureProvider = FutureProvider<List<Product>>((ref) async {
  final productRepository = ref.watch(productRepositoryProvider);
  return productRepository.fetchProcutList();
});

final productProvider = StreamProvider.autoDispose.family<Product?, String>((ref, productID) {
  debugPrint('Created product Provider with id $productID');
  final productRepository = ref.watch(productRepositoryProvider);
  final link = ref.keepAlive();
  Timer(const Duration(seconds: 10), () {
    link.close();
  });
  ref.onDispose(() => debugPrint('Product provider disposed with id $productID'));
  return productRepository.watchProduct(productID);
});
