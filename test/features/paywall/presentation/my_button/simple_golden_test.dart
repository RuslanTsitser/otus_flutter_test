import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/features/paywall/presentation/components/product_label.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  testWidgets('Creating a golden image with a custom font', (WidgetTester tester) async {
    // Assuming the 'Roboto.ttf' file is declared in the pubspec.yaml file
    final Future<ByteData> font = rootBundle.load('assets/fonts/montserrat/Montserrat-Medium.ttf');

    final FontLoader fontLoader = FontLoader('Montserrat')..addFont(font);
    await fontLoader.load();

    await tester.pumpWidget(
      MaterialApp(
        home: Directionality(textDirection: TextDirection.ltr, child: const ProductLabel()),
      ),
    );

    await expectLater(
      find.byType(ProductLabel),
      matchesGoldenFile('myWidget.png'),
    );
  });
}
