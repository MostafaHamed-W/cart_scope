// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';

import 'package:cart_scope/src/features/cart/data/local/local_cart_repository.dart';
import 'package:cart_scope/src/features/cart/domain/cart.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastCartRepository extends LocalCartRepository {
  SembastCartRepository({
    required this.db,
  });
  final Database db;

  static Future<Database> createDatabase(String filename) async {
    if (!kIsWeb) {
      final appDicDir = await getApplicationCacheDirectory();
      return databaseFactoryIo.openDatabase('${appDicDir.path}/$filename');
    } else {
      return databaseFactoryWeb.openDatabase(filename);
    }
  }

  static Future<SembastCartRepository> makeDefault() async {
    return SembastCartRepository(db: await createDatabase('default.db'));
  }

  @override
  Future<Cart> fetchCart() {
    // TODO: implement fetchCart
    throw UnimplementedError();
  }

  @override
  Future<void> setCart(Cart cart) {
    // TODO: implement setCart
    throw UnimplementedError();
  }

  @override
  Stream<Cart> watchCart() {
    // TODO: implement watchCart
    throw UnimplementedError();
  }
}
