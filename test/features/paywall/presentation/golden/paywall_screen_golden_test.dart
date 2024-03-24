import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/paywall/domain/paywall_product.dart';
import 'package:flutter_application_1/features/paywall/logic/products_notifier.dart';
import 'package:flutter_application_1/features/paywall/presentation/paywall_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'paywall_screen_golden_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProductsNotifier>()])
void main() async {
  // Load fonts from assets to show text instead of black rectangles
  await loadAppFonts();

  group('paywall screen golden tests', () {
    late MockProductsNotifier mockProductsNotifier;

    setUpAll(() {
      mockProductsNotifier = MockProductsNotifier();
    });

    tearDown(() {
      reset(mockProductsNotifier);
    });

    testGoldens('Paywall Screen with Products', (WidgetTester tester) async {
      const products = <PaywallProduct>[
        PaywallProduct(title: 'Product 1', price: '10'),
        PaywallProduct(title: 'Product 2', price: '20'),
      ];
      when(mockProductsNotifier.products).thenReturn(products);
      when(mockProductsNotifier.loading).thenReturn(false);
      when(mockProductsNotifier.fetchProducts()).thenAnswer((_) async {});

      final widget = MultiProvider(
        providers: [
          ChangeNotifierProvider<ProductsNotifier>.value(value: mockProductsNotifier),
        ],
        child: const MaterialApp(
          home: PaywallScreen(),
        ),
      );

      final builder = DeviceBuilder()
        ..addScenario(
          name: 'Paywall Screen with Products',
          widget: widget,
        );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'paywall_screen_with_products');
    });
  });
}
