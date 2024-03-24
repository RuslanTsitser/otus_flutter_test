import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/paywall/domain/paywall_product.dart';
import 'package:flutter_application_1/features/paywall/presentation/components/product_card.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  testWidgets(
    'ProductCard displays correct title and price',
    (WidgetTester tester) async {
      const product = PaywallProduct(
        title: 'Test Product',
        price: '10.99',
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ProductCard(product: product),
          ),
        ),
      );

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('10.99'), findsOneWidget);
    },
  );

  testWidgets('ProductCard renders correctly', (tester) async {
    const product = PaywallProduct(
      title: 'Test Product',
      price: '10.99',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProductCard(product: product),
        ),
      ),
    );

    expect(
      find.byType(ProductCard),
      paints
        ..save()
        ..path()
        ..restore()
        ..paragraph()
        ..paragraph(),
    );
  });
}
