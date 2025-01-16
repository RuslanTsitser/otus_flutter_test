import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:url_launcher/url_launcher.dart';

const MethodChannel _channel = MethodChannel('plugins.flutter.io/url_launcher');

Future<bool> handler(MethodCall methodCall) async {
  if (methodCall.method == 'canLaunch' && methodCall.arguments == 'https://www.google.com') {
    return true;
  } else if (methodCall.method == 'launch') {
    return true;
  }
  return false;
}

void main() async {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(_channel, handler);
  });
  group('MethodChannel test', () {
    test(
      'test method channel calls',
      () async {
        final result = await launchUrl(Uri.parse('https://www.google.com'));
        expect(result, true);
        // expect(await _channel.invokeMethod('canLaunch', 'https://www.google.com'), true);
        // expect(await _channel.invokeMethod('launch', 'https://www.google.com'), true);
        // expect(await _channel.invokeMethod('hello', 'https://www.google.com'), false);
      },
    );
  });
}
