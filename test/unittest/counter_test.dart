// Correct the import path according to your project structure and package name
import 'package:fluttercommerce/counter.dart';
import 'package:test/test.dart';

void main() {
  group('Counter tests', () {
    test('Counter value should be incremented', () {
      final counter = Counter();
      counter.increment();
      expect(counter.value, 1);
    });

    test('Counter value should be decremented', () {
      final counter = Counter();
      counter.increment();
      counter.decrement();
      expect(counter.value, 0);
    });
  });
}

