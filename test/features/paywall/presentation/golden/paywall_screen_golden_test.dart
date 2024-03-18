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
  testGoldens('Paywall Screen with Products', (WidgetTester tester) async {
    final mockProductsNotifier = MockProductsNotifier();
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

    await tester.pumpWidgetBuilder(widget);

    await multiScreenGolden(
      tester,
      'paywall_screen_golden_test_with_products',
      devices: [
        Device.iphone11,
        Device.phone,
      ],
    );
  });

  testGoldens('Paywall Screen empty Products', (WidgetTester tester) async {
    final mockProductsNotifier = MockProductsNotifier();
    const products = <PaywallProduct>[];
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

    await tester.pumpWidgetBuilder(widget);

    await multiScreenGolden(
      tester,
      'paywall_screen_golden_test_empty_products',
      devices: [
        Device.iphone11,
        Device.phone,
      ],
      // for testing with animations
      customPump: (tester) => tester.pump(const Duration(milliseconds: 100)),
    );
  });

  testGoldens('Paywall Screen loading Products', (WidgetTester tester) async {
    final mockProductsNotifier = MockProductsNotifier();
    const products = <PaywallProduct>[];
    when(mockProductsNotifier.products).thenReturn(products);
    when(mockProductsNotifier.loading).thenReturn(true);
    when(mockProductsNotifier.fetchProducts()).thenAnswer((_) async {});

    final widget = MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductsNotifier>.value(value: mockProductsNotifier),
      ],
      child: const MaterialApp(
        home: PaywallScreen(),
      ),
    );

    await tester.pumpWidgetBuilder(widget);

    await multiScreenGolden(
      tester,
      'paywall_screen_golden_test_loading_products',
      devices: [
        Device.iphone11,
        Device.phone,
      ],
      // for testing with animations
      customPump: (tester) => tester.pump(const Duration(milliseconds: 100)),
    );
  });

  testGoldens('Paywall Screen Golden Test - With Products', (WidgetTester tester) async {
    final mockProductsNotifier = MockProductsNotifier();
    const products = <PaywallProduct>[
      PaywallProduct(title: 'Product 1', price: '10'),
      PaywallProduct(title: 'Product 2', price: '20'),
    ];

    final widget = MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductsNotifier>.value(value: mockProductsNotifier),
      ],
      child: const MaterialApp(
        home: PaywallScreen(),
      ),
    );

    final builder = DeviceBuilder();

    when(mockProductsNotifier.products).thenReturn(products);
    when(mockProductsNotifier.loading).thenReturn(false);
    when(mockProductsNotifier.fetchProducts()).thenAnswer((_) async {});
    builder.addScenario(
      widget: widget,
      name: 'paywall_screen_golden_test',
    );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(
      tester,
      'paywall_screen_golden_test_with_products',
      customPump: (tester) => tester.pump(const Duration(milliseconds: 100)),
    );
  });

  testGoldens('Paywall Screen Golden Test - Empty Products', (WidgetTester tester) async {
    final mockProductsNotifier = MockProductsNotifier();
    const products = <PaywallProduct>[];

    final widget = MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductsNotifier>.value(value: mockProductsNotifier),
      ],
      child: const MaterialApp(
        home: PaywallScreen(),
      ),
    );

    final builder = DeviceBuilder();

    when(mockProductsNotifier.products).thenReturn(products);
    when(mockProductsNotifier.loading).thenReturn(false);
    when(mockProductsNotifier.fetchProducts()).thenAnswer((_) async {});
    builder.addScenario(
      widget: widget,
      name: 'paywall_screen_golden_test_empty_products',
    );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(
      tester,
      'paywall_screen_golden_test_empty_products',
      customPump: (tester) => tester.pump(const Duration(milliseconds: 100)),
    );
  });

  testGoldens('Paywall Screen Golden Test - Loading Products', (WidgetTester tester) async {
    final mockProductsNotifier = MockProductsNotifier();
    const products = <PaywallProduct>[];

    final widget = MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductsNotifier>.value(value: mockProductsNotifier),
      ],
      child: const MaterialApp(
        home: PaywallScreen(),
      ),
    );

    final builder = DeviceBuilder();

    when(mockProductsNotifier.products).thenReturn(products);
    when(mockProductsNotifier.loading).thenReturn(true);
    when(mockProductsNotifier.fetchProducts()).thenAnswer((_) async {});
    builder.addScenario(
      widget: widget,
      name: 'paywall_screen_golden_test_loading_products',
    );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(
      tester,
      'paywall_screen_golden_test_loading_products',
      customPump: (tester) => tester.pump(const Duration(milliseconds: 100)),
    );
  });
}
