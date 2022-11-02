import 'package:flutter_test/flutter_test.dart';
import 'package:pro_counter/src/application/counter/counter_bloc.dart';

void main() {
  group('CounterState', () {
    test('value', () {
      expect(const CounterState.value(0), const CounterState.value(0));
    });
  });
}
