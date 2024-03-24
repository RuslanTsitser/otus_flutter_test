import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MyClass {
  void myFunction(String value) {}
}

class MockMyClass extends Mock implements MyClass {}

void main() {
  test('захват аргументов в моках', () {
    final myMock = MockMyClass();

    myMock.myFunction('Hello');

    final capturedArg = verify(() => myMock.myFunction(captureAny())).captured;

    expect(capturedArg, equals(['Hello']));
  });
}
