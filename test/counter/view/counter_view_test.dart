import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pro_counter/presentation/core/helpers/widget_keys.dart';
import 'package:pro_counter/presentation/counter/counter.dart';

import '../../helpers/helpers.dart';

class MockCounterBloc extends MockBloc<CounterEvent, CounterState>
    implements CounterBloc {}

class FakeCounterEvent extends Fake implements CounterEvent {}

class FakeCounterState extends Fake implements CounterState {}

void main() {
  setUpAll(
    () {
      registerFallbackValue(FakeCounterEvent());
      registerFallbackValue(FakeCounterState());
    },
  );
  group('CounterView', () {
    testWidgets('renders CounterPage', (tester) async {
      await mockHydratedStorage(() async {
        await tester.pumpApp(const CounterView());
      });
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });

  group('CounterPage', () {
    late CounterBloc counterBloc;

    setUp(() {
      counterBloc = MockCounterBloc();
    });

    testWidgets('renders current count', (tester) async {
      const state = 0;
      when(() => counterBloc.state).thenReturn(const CounterState.value(state));
      when(() => counterBloc.canUndo).thenReturn(true);
      when(() => counterBloc.canRedo).thenReturn(true);
      await mockHydratedStorage(
        () async {
          await tester.pumpApp(
            BlocProvider.value(
              value: counterBloc,
              child: const CounterPage(),
            ),
          );
        },
      );

      expect(find.text('$state'), findsOneWidget);
    });

    testWidgets('calls increment when increment button is tapped',
        (tester) async {
      when(() => counterBloc.state).thenReturn(const CounterState.value(0));
      when(() => counterBloc.add(const CounterEvent.increment()))
          .thenReturn(null);
      when(() => counterBloc.canUndo).thenReturn(true);
      when(() => counterBloc.canRedo).thenReturn(true);
      await mockHydratedStorage(
        () async {
          await tester.pumpApp(
            BlocProvider.value(
              value: counterBloc,
              child: const CounterPage(),
            ),
          );
          await tester.tap(find.byKey(WidgetKeys.counterIncrementButtonKey));
          verify(() => counterBloc.add(const CounterEvent.increment()))
              .called(1);
        },
      );
    });

    testWidgets('calls decrement when decrement button is tapped',
        (tester) async {
      when(() => counterBloc.state).thenReturn(const CounterState.value(0));
      when(() => counterBloc.add(const CounterEvent.decrement()))
          .thenReturn(null);
      when(() => counterBloc.canUndo).thenReturn(true);
      when(() => counterBloc.canRedo).thenReturn(true);
      await mockHydratedStorage(
        () async {
          await tester.pumpApp(
            BlocProvider.value(
              value: counterBloc,
              child: const CounterPage(),
            ),
          );
          await tester.tap(find.byKey(WidgetKeys.counterDecrementButtonKey));
          verify(() => counterBloc.add(const CounterEvent.decrement()))
              .called(1);
        },
      );
    });

    testWidgets('calls reset when reset button is tapped', (tester) async {
      when(() => counterBloc.state).thenReturn(const CounterState.value(0));
      when(() => counterBloc.add(const CounterEvent.reset())).thenReturn(null);
      when(() => counterBloc.canUndo).thenReturn(true);
      when(() => counterBloc.canRedo).thenReturn(true);
      await mockHydratedStorage(
        () async {
          await tester.pumpApp(
            BlocProvider.value(
              value: counterBloc,
              child: const CounterPage(),
            ),
          );
          await tester.tap(find.byKey(WidgetKeys.counterResetButtonKey));
          verify(() => counterBloc.add(const CounterEvent.reset())).called(1);
        },
      );
    });

    testWidgets('calls undo when undo button is tapped', (tester) async {
      when(() => counterBloc.state).thenReturn(const CounterState.value(0));
      when(() => counterBloc.canUndo).thenReturn(true);
      when(() => counterBloc.canRedo).thenReturn(true);
      await mockHydratedStorage(
        () async {
          await tester.pumpApp(
            BlocProvider.value(
              value: counterBloc,
              child: const CounterPage(),
            ),
          );
          await tester.tap(find.byKey(WidgetKeys.counterUndoButtonKey));
          verify(() => counterBloc.undo()).called(1);
        },
      );
    });

    testWidgets('calls redo when redo button is tapped', (tester) async {
      when(() => counterBloc.state).thenReturn(const CounterState.value(0));
      when(() => counterBloc.canUndo).thenReturn(true);
      when(() => counterBloc.canRedo).thenReturn(true);
      await mockHydratedStorage(
        () async {
          await tester.pumpApp(
            BlocProvider.value(
              value: counterBloc,
              child: const CounterPage(),
            ),
          );
          await tester.tap(find.byKey(WidgetKeys.counterRedoButtonKey));
          verify(() => counterBloc.redo()).called(1);
        },
      );
    });
  });
}
