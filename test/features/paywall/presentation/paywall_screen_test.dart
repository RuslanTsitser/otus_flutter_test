import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/paywall/domain/paywall_product.dart';
import 'package:flutter_application_1/features/paywall/domain/paywall_repository.dart';
import 'package:flutter_application_1/features/paywall/logic/products_notifier.dart';
import 'package:flutter_application_1/features/paywall/presentation/paywall_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockPaywallRepository extends Mock implements PaywallRepository {}

void main() {
  group(
    'PaywallScreen',
    () {
      late PaywallRepository mockPaywallRepository;

      setUpAll(() {
        mockPaywallRepository = MockPaywallRepository();
      });

      tearDown(() {
        reset(mockPaywallRepository);
      });

      testWidgets(
        'should not display loading indicator\n'
        'and display products when products are fetched\n'
        'and display loading indicator when fetching products',
        (tester) async {
          when(() => mockPaywallRepository.getProducts()).thenAnswer((_) async {
            await Future.delayed(const Duration(seconds: 2));
            return const [
              PaywallProduct(title: 'Product 1', price: '10'),
              PaywallProduct(title: 'Product 2', price: '20'),
            ];
          });
          await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (context) => ProductsNotifier(mockPaywallRepository)),
              ],
              child: const MaterialApp(
                home: PaywallScreen(),
              ),
            ),
          );

          expect(find.byType(CircularProgressIndicator), findsNothing);
          expect(find.byType(ElevatedButton), findsOneWidget);
          expect(find.text('Fetch products'), findsOneWidget);

          await tester.tap(find.byKey(const Key('fetch_products_button')));

          await tester.pump();
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          await tester.pump(const Duration(seconds: 1));
          expect(find.byType(CircularProgressIndicator), findsOneWidget);

          await tester.pump(const Duration(seconds: 2));
          expect(find.byType(CircularProgressIndicator), findsNothing);
          expect(find.text('Product 1'), findsOneWidget);
          expect(find.text('Product 2'), findsOneWidget);
        },
      );
    },
  );
}
