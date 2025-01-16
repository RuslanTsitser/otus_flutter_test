import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/paywall/presentation/paywall_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

void main() async {
  group('Mock widget', () {
    testWidgets('hello', (WidgetTester tester) async {
      final widget = MaterialApp(home: Scaffold(body: Center(child: MyImage())));

      await mockNetworkImages(() async => tester.pumpWidget(widget));
      // await tester.pumpWidget(widget);
      expect(find.byType(Image), findsAtLeastNWidgets(1));
    });
  });
}
