import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pro_counter/src/application/counter/counter_bloc.dart';

import '../../helpers/helpers.dart';

void main() {
  group('CounterBloc', () {
    late CounterBloc counterBloc;

    setUp(() {
      mockHydratedStorage(
        () {
          counterBloc = CounterBloc();
        },
      );
    });

    tearDown(() {
      counterBloc.close();
    });

    test('initial state is correct', () {
      expect(counterBloc.state, const CounterState.value(0));
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
      build: () => mockHydratedStorage(CounterBloc.new),
      act: (bloc) => bloc..add(const CounterEvent.increment()),
      expect: () => <CounterState>[const CounterState.value(1)],
    );

    blocTest<CounterBloc, CounterState>(
      'emits [-1] when decrement is called',
      build: () => mockHydratedStorage(CounterBloc.new),
      act: (bloc) => bloc..add(const CounterEvent.decrement()),
      expect: () => <CounterState>[const CounterState.value(-1)],
    );

    blocTest<CounterBloc, CounterState>(
      'emits [0] when reset is called',
      build: () => mockHydratedStorage(CounterBloc.new),
      act: (bloc) => bloc..add(const CounterEvent.reset()),
      expect: () => <CounterState>[const CounterState.value(0)],
    );

    group('canUndo', () {
      test('is false when no state changes have occurred', () async {
        await mockHydratedStorage(
          () async {
            final bloc = CounterBloc();
            expect(bloc.canUndo, isFalse);
            await bloc.close();
          },
        );
      });

      test('is true when a single state change has occurred', () async {
        await mockHydratedStorage(
          () async {
            final bloc = CounterBloc()..add(const CounterEvent.increment());
            await Future<void>.delayed(Duration.zero);
            expect(bloc.canUndo, isTrue);
            await bloc.close();
          },
        );
      });

      test('is false when undos have been exhausted', () async {
        await mockHydratedStorage(
          () async {
            final bloc = CounterBloc()..add(const CounterEvent.increment());
            await Future<void>.delayed(Duration.zero, bloc.undo);
            expect(bloc.canUndo, isFalse);
            await bloc.close();
          },
        );
      });
    });

    group('canRedo', () {
      test('is false when no state changes have occurred', () async {
        await mockHydratedStorage(
          () async {
            final bloc = CounterBloc();
            expect(bloc.canRedo, isFalse);
            await bloc.close();
          },
        );
      });

      test('is true when a single undo has occurred', () async {
        await mockHydratedStorage(
          () async {
            final bloc = CounterBloc()..add(const CounterEvent.increment());
            await Future<void>.delayed(Duration.zero, bloc.undo);
            expect(bloc.canRedo, isTrue);
            await bloc.close();
          },
        );
      });

      test('is false when redos have been exhausted', () async {
        await mockHydratedStorage(
          () async {
            final bloc = CounterBloc()..add(const CounterEvent.increment());
            await Future<void>.delayed(Duration.zero, bloc.undo);
            await Future<void>.delayed(Duration.zero, bloc.redo);
            expect(bloc.canRedo, isFalse);
            await bloc.close();
          },
        );
      });
    });

    group('clearHistory', () {
      test('clears history and redos on new bloc', () async {
        await mockHydratedStorage(
          () async {
            final bloc = CounterBloc()..clearHistory();
            expect(bloc.canRedo, isFalse);
            expect(bloc.canUndo, isFalse);
            await bloc.close();
          },
        );
      });
    });
  });
}
