import 'package:fake_async/fake_async.dart';
import 'package:flutter_application_1/features/paywall/domain/paywall_product.dart';
import 'package:flutter_application_1/features/paywall/domain/paywall_repository.dart';
import 'package:flutter_application_1/features/paywall/logic/products_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<PaywallRepository>()])
import 'products_notifier_test.mocks.dart';

void main() {
  group('ProductsNotifier', () {
    late ProductsNotifier productsNotifier;
    late MockPaywallRepository mockPaywallRepository;
    const mockProducts = [
      PaywallProduct(title: 'Product 1', price: '10'),
      PaywallProduct(title: 'Product 2', price: '20'),
    ];

    setUp(() {
      mockPaywallRepository = MockPaywallRepository();
      productsNotifier = ProductsNotifier(mockPaywallRepository);
    });

    tearDown(() {
      reset(mockPaywallRepository);
      productsNotifier.dispose();
    });

    test('fetchProducts should update products list and loading status', () async {
      when(mockPaywallRepository.getProducts(any)).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 10));
        return mockProducts;
      });
      fakeAsync((fAsync) {
        expect(productsNotifier.loading, isFalse);
        expect(productsNotifier.products, isEmpty);

        productsNotifier.fetchProducts();
        expect(productsNotifier.loading, isTrue);
        expect(productsNotifier.products, isEmpty);
        // await Future.delayed(const Duration(seconds: 2));
        fAsync.elapse(const Duration(seconds: 11));
        expect(productsNotifier.loading, isFalse);
        expect(productsNotifier.products, mockProducts);
      });
    });

    test(
      'fetchProducts should return exception',
      () async {
        when(mockPaywallRepository.getProducts(any)).thenThrow(Exception('no internet'));

        expect(productsNotifier.loading, isFalse);
        expect(productsNotifier.products, isEmpty);

        productsNotifier.fetchProducts();
        expect(productsNotifier.isError, isTrue);
      },
    );
  });
}
