import 'package:cart_scope/src/features/products/data/fake_products_repository.dart';
import 'package:cart_scope/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsSearchQueryStateProvider = StateProvider<String>((ref) {
  return '';
});

final productsSearchResultsProvider = FutureProvider.autoDispose<List<Product>>((ref) async {
  final productSearchText = ref.watch(productsSearchQueryStateProvider);
  return ref.watch(productListSerchProvider(productSearchText).future);
});
