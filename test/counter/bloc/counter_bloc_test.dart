import 'package:bloc_test/bloc_test.dart';
import 'package:pro_counter/presentation/counter/bloc/counter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/helpers.dart';

void main() {
  group('CounterBloc', () {
    late CounterBloc counterBloc;

    setUpAll(initHydratedBloc);

    setUp(() {
      counterBloc = CounterBloc();
    });

    tearDown(() {
      counterBloc.close();
    });

    test('initial state is correct', () {
      expect(counterBloc.state, const CounterState.initial());
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        expect(
          counterBloc.fromJson(counterBloc.toJson(counterBloc.state)),
          counterBloc.state,
        );
      });
    });

    blocTest<CounterBloc, CounterState>(
      'emits [1] when increment is called',
      build: () => CounterBloc(),
      act: (bloc) => bloc.add(const CounterEvent.increment()),
      expect: () => [equals(const CounterState.current(1))],
    );

    blocTest<CounterBloc, CounterState>(
      'emits [-1] when decrement is called',
      build: () => CounterBloc(),
      act: (bloc) => bloc.add(const CounterEvent.decrement()),
      expect: () => [equals(const CounterState.current(-1))],
    );

    blocTest<CounterBloc, CounterState>(
      'emits [0] when reset is called',
      build: () => CounterBloc(),
      act: (bloc) => bloc.add(const CounterEvent.reset()),
      expect: () => [equals(const CounterState.current(0))],
    );

    group('canUndo', () {
      test('is false when no state changes have occurred', () async {
        final bloc = CounterBloc();
        expect(bloc.canUndo, isFalse);
        await bloc.close();
      });

      test('is true when a single state change has occurred', () async {
        final bloc = CounterBloc()..add(const CounterEvent.increment());
        await Future<void>.delayed(Duration.zero);
        expect(bloc.canUndo, isTrue);
        await bloc.close();
      });

      test('is false when undos have been exhausted', () async {
        final bloc = CounterBloc()..add(const CounterEvent.increment());
        await Future<void>.delayed(Duration.zero, bloc.undo);
        expect(bloc.canUndo, isFalse);
        await bloc.close();
      });
    });

    group('canRedo', () {
      test('is false when no state changes have occurred', () async {
        final bloc = CounterBloc();
        expect(bloc.canRedo, isFalse);
        await bloc.close();
      });

      test('is true when a single undo has occurred', () async {
        final bloc = CounterBloc()..add(const CounterEvent.increment());
        await Future<void>.delayed(Duration.zero, bloc.undo);
        expect(bloc.canRedo, isTrue);
        await bloc.close();
      });

      test('is false when redos have been exhausted', () async {
        final bloc = CounterBloc()..add(const CounterEvent.increment());
        await Future<void>.delayed(Duration.zero, bloc.undo);
        await Future<void>.delayed(Duration.zero, bloc.redo);
        expect(bloc.canRedo, isFalse);
        await bloc.close();
      });
    });

    group('clearHistory', () {
      test('clears history and redos on new bloc', () async {
        final bloc = CounterBloc()..clearHistory();
        expect(bloc.canRedo, isFalse);
        expect(bloc.canUndo, isFalse);
        await bloc.close();
      });
    });
  });
}
