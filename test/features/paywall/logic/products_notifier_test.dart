import 'package:fake_async/fake_async.dart';
import 'package:flutter_application_1/features/paywall/domain/paywall_product.dart';
import 'package:flutter_application_1/features/paywall/domain/paywall_repository.dart';
import 'package:flutter_application_1/features/paywall/logic/products_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
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
      when(mockPaywallRepository.getProducts()).thenAnswer((_) async {
        await Future.delayed(const Duration(seconds: 1));
        return mockProducts;
      });
    });

    tearDown(() {
      reset(mockPaywallRepository);
      productsNotifier.dispose();
    });

    test('fetchProducts should update products list and loading status', () async {
      fakeAsync((async) {
        expect(productsNotifier.loading, false);
        expect(productsNotifier.products, []);

        productsNotifier.fetchProducts();
        expect(productsNotifier.loading, true);
        expect(productsNotifier.products, []);

        async.elapse(const Duration(seconds: 3));
        expect(productsNotifier.loading, false);
        expect(productsNotifier.products, mockProducts);
      });
    });

    test(
      'fetchProducts should return exception',
      () async {
        when(mockPaywallRepository.getProducts()).thenThrow(Exception('no internet'));

        expect(productsNotifier.loading, false);
        expect(productsNotifier.products, []);

        productsNotifier.fetchProducts();
        expect(productsNotifier.isError, true);
      },
    );
  });
}
