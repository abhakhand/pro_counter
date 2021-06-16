import 'package:bloc_test/bloc_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pro_counter/presentation/counter/bloc/counter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    );
  });

  group('CounterBloc', () {
    test('initial state is 0', () {
      expect(
        const CounterState.initial(),
        equals(
          const CounterState.initial(0),
        ),
      );
    });

    blocTest<CounterBloc, CounterState>(
      'emits [1] when increment is called',
      build: () => CounterBloc(),
      act: (bloc) => bloc.add(const CounterEvent.increment()),
      expect: () => [equals(const CounterState.current(1))],
      verify: (bloc) => bloc.clear(),
    );

    blocTest<CounterBloc, CounterState>(
      'emits [-1] when decrement is called',
      build: () => CounterBloc(),
      act: (bloc) => bloc.add(const CounterEvent.decrement()),
      expect: () => [equals(const CounterState.current(-1))],
    );

    test('cached state is -1', () {
      expect(
        const CounterState.current(-1),
        equals(
          const CounterState.current(-1),
        ),
      );
    });

    blocTest<CounterBloc, CounterState>(
      'emits [0] when reset is called',
      build: () => CounterBloc(),
      act: (bloc) => bloc.add(const CounterEvent.reset()),
      expect: () => [equals(const CounterState.current(0))],
    );
  });
}
