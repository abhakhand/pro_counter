import 'package:flutter_test/flutter_test.dart';
import 'package:pro_counter/src/application/counter/counter_bloc.dart';

void main() {
  group('CounterEvent', () {
    test('increment', () {
      expect(const CounterEvent.increment(), const CounterEvent.increment());
    });

    test('decrement', () {
      expect(const CounterEvent.decrement(), const CounterEvent.decrement());
    });

    test('reset', () {
      expect(const CounterEvent.reset(), const CounterEvent.reset());
    });
  });
}
