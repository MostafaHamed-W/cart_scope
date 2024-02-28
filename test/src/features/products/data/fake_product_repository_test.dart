@Timeout(Duration(milliseconds: 500))
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

  // We Can Group all related test together in group() method
  group(
    'FakeProductRepositlry Unit Testing',
    () {
      test(
        'Test products list that returned from getProductsList',
        () => expect(
          fakeProductRepository.getProductList(),
          kTestProducts,
        ),
      );

      test(
        'Test get Product by id funtion getProcut(1) return first item',
        () => expect(
          fakeProductRepository.getProduct('1'),
          kTestProducts[0],
        ),
      );

      test(
        'Test get Product by id funtion getProcut(1) return null',
        () => expect(
          fakeProductRepository.getProduct('100'),
          null,
        ),
      );

      // Handle Unit Testing with Future by using async and await
      test(
        'Test fetchProductList',
        () async => expect(
          await fakeProductRepository.fetchProcutList(),
          kTestProducts,
        ),
      );

      // Handle Unit Testing with Streams by using emits() Matcher
      test(
        'Test watchProductList function',
        () => expect(
          fakeProductRepository.watchProcustList(),
          emits(kTestProducts),
        ),
      );

      test(
        'Test watchProduct function',
        () => expect(
          fakeProductRepository.watchProduct('1'),
          emits(kTestProducts[0]),
        ),
      );

      test(
        'Test watchProducts function with null return',
        () => expect(
          fakeProductRepository.watchProduct('100'),
          emits(null),
        ),
      );
    },
  );
}



  // test(
  //   'Test get Product by id funtion',
  //   () => expect(
  //     fakeProductRepository.getProduct('1'),
  //     kTestProducts[0],
  //   ),
  // );

  /// but the return of getProduct('100') will be bad state
  /// due to .firstWhere() behaviour as it return with state error when we it
  /// couldn't find an element, so we should use orElse on it, but we cannot do it
  /// because it's a list<product> not list<product?> so we use Matchers: throwsStateError

  // test(
  //   'Test get Product by id funtion',
  //   () => expect(
  //     fakeProductRepository.getProduct('100'),
  //     throwsStateError,
  //   ),
  // );

  /// Why the prevoius method test didn't work although we used Matchers?
  /// because the fakeProductRepository.getProduct('100') throw the exception
  /// before expect method execute, so we put it in closure ()=> method
  /// 
  /// 
  /// or instead of all of these we can refactor our code to return null
  /// when it cannot find the item : this refactor in FakeProductRepository