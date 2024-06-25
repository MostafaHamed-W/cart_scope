import 'package:cart_scope/src/features/products/data/fake_products_repository.dart';
import 'package:cart_scope/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'products_searach_state_provider.g.dart';

final productsSearchQueryStateProvider = StateProvider<String>((ref) {
  return '';
});

@riverpod
Future<List<Product>> productsSearchResults(ProductsSearchResultsRef ref) async {
  final productSearchText = ref.watch(productsSearchQueryStateProvider);
  return ref.watch(productListSerchProvider(productSearchText).future);
}
