import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/paywall/presentation/paywall_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

void main() async {
  // Load fonts from assets to show text instead of black rectangles
  await loadAppFonts();

  group('paywall screen golden tests', () {
    testGoldens('Paywall Screen with Products', (WidgetTester tester) async {
      final widget = Scaffold(body: Center(child: MyButton()));

      final builder = DeviceBuilder()
        ..addScenario(
          name: 'My Button',
          widget: widget,
        );

      await tester.pumpDeviceBuilder(builder);

      await screenMatchesGolden(tester, 'my_button');
    });
  });
}
