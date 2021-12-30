import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pro_counter/src/application/counter/counter_bloc.dart';
import 'package:pro_counter/src/application/theme/theme_cubit.dart';
import 'package:pro_counter/src/presentation/core/helpers/widget_keys.dart';
import 'package:pro_counter/src/presentation/counter/views/counter_view.dart';
import 'package:pro_counter/src/presentation/counter/widgets/widgets.dart';

import '../../helpers/helpers.dart';

class MockCounterBloc extends MockBloc<CounterEvent, CounterState>
    implements CounterBloc {}

class FakeCounterEvent extends Fake implements CounterEvent {}

class FakeCounterState extends Fake implements CounterState {}

class MockThemeCubit extends MockCubit<ThemeMode> implements ThemeCubit {}

void main() {
  setUpAll(
    () {
      registerFallbackValue(FakeCounterEvent());
      registerFallbackValue(FakeCounterState());
      registerFallbackValue(ThemeMode);
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
    late ThemeCubit themeCubit;

    setUp(() {
      counterBloc = MockCounterBloc();
      themeCubit = MockThemeCubit();
    });

    testWidgets('renders ThemeSwitcherButton', (tester) async {
      const counterState = 0;
      const themeState = ThemeMode.dark;
      when(() => counterBloc.state)
          .thenReturn(const CounterState.value(counterState));
      when(() => counterBloc.canUndo).thenReturn(true);
      when(() => counterBloc.canRedo).thenReturn(true);
      when(() => themeCubit.state).thenReturn(themeState);
      await mockHydratedStorage(() async {
        await tester.pumpApp(
          MultiBlocProvider(
            providers: [
              BlocProvider.value(value: counterBloc),
              BlocProvider.value(value: themeCubit),
            ],
            child: const CounterPage(),
          ),
        );
      });
      expect(find.byType(ThemeSwitcherButton), findsOneWidget);
    });

    testWidgets('renders UndoButton', (tester) async {
      const counterState = 0;
      const themeState = ThemeMode.dark;
      when(() => counterBloc.state)
          .thenReturn(const CounterState.value(counterState));
      when(() => counterBloc.canUndo).thenReturn(true);
      when(() => counterBloc.canRedo).thenReturn(true);
      when(() => themeCubit.state).thenReturn(themeState);
      await mockHydratedStorage(() async {
        await tester.pumpApp(
          MultiBlocProvider(
            providers: [
              BlocProvider.value(value: counterBloc),
              BlocProvider.value(value: themeCubit),
            ],
            child: const CounterPage(),
          ),
        );
      });
      expect(find.byType(UndoButton), findsOneWidget);
    });

    testWidgets('renders RedoButton', (tester) async {
      const counterState = 0;
      const themeState = ThemeMode.dark;
      when(() => counterBloc.state)
          .thenReturn(const CounterState.value(counterState));
      when(() => counterBloc.canUndo).thenReturn(true);
      when(() => counterBloc.canRedo).thenReturn(true);
      when(() => themeCubit.state).thenReturn(themeState);
      await mockHydratedStorage(() async {
        await tester.pumpApp(
          MultiBlocProvider(
            providers: [
              BlocProvider.value(value: counterBloc),
              BlocProvider.value(value: themeCubit),
            ],
            child: const CounterPage(),
          ),
        );
      });
      expect(find.byType(RedoButton), findsOneWidget);
    });

    testWidgets('renders ResetButton', (tester) async {
      const counterState = 0;
      const themeState = ThemeMode.dark;
      when(() => counterBloc.state)
          .thenReturn(const CounterState.value(counterState));
      when(() => counterBloc.canUndo).thenReturn(true);
      when(() => counterBloc.canRedo).thenReturn(true);
      when(() => themeCubit.state).thenReturn(themeState);
      await mockHydratedStorage(() async {
        await tester.pumpApp(
          MultiBlocProvider(
            providers: [
              BlocProvider.value(value: counterBloc),
              BlocProvider.value(value: themeCubit),
            ],
            child: const CounterPage(),
          ),
        );
      });
      expect(find.byType(ResetButton), findsOneWidget);
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

    testWidgets('renders current theme', (tester) async {
      const counterState = 0;
      const themeState = ThemeMode.dark;
      when(() => counterBloc.state)
          .thenReturn(const CounterState.value(counterState));
      when(() => counterBloc.canUndo).thenReturn(true);
      when(() => counterBloc.canRedo).thenReturn(true);
      when(() => themeCubit.state).thenReturn(themeState);
      await mockHydratedStorage(
        () async {
          await tester.pumpApp(
            MultiBlocProvider(
              providers: [
                BlocProvider.value(value: counterBloc),
                BlocProvider.value(value: themeCubit),
              ],
              child: const CounterPage(),
            ),
          );
        },
      );

      expect(find.byKey(WidgetKeys.themeWidgetKey), findsOneWidget);
    });

    testWidgets('calls switchTheme(Light) when theme button is tapped',
        (tester) async {
      when(() => counterBloc.state).thenReturn(const CounterState.value(0));
      when(() => counterBloc.canUndo).thenReturn(true);
      when(() => counterBloc.canRedo).thenReturn(true);
      when(() => themeCubit.state).thenReturn(ThemeMode.dark);
      when(() => themeCubit.switchThemeMode(ThemeMode.light)).thenReturn(null);
      await mockHydratedStorage(
        () async {
          await tester.pumpApp(
            MultiBlocProvider(
              providers: [
                BlocProvider.value(value: counterBloc),
                BlocProvider.value(value: themeCubit),
              ],
              child: const CounterPage(),
            ),
          );
          await tester.tap(find.byKey(WidgetKeys.themeButtonKey));
          verify(() => themeCubit.switchThemeMode(ThemeMode.light)).called(1);
        },
      );
    });

    testWidgets('calls switchTheme(Dark) when theme button is tapped',
        (tester) async {
      when(() => counterBloc.state).thenReturn(const CounterState.value(0));
      when(() => counterBloc.canUndo).thenReturn(true);
      when(() => counterBloc.canRedo).thenReturn(true);
      when(() => themeCubit.state).thenReturn(ThemeMode.light);
      when(() => themeCubit.switchThemeMode(ThemeMode.dark)).thenReturn(null);
      await mockHydratedStorage(
        () async {
          await tester.pumpApp(
            MultiBlocProvider(
              providers: [
                BlocProvider.value(value: counterBloc),
                BlocProvider.value(value: themeCubit),
              ],
              child: const CounterPage(),
            ),
          );
          await tester.tap(find.byKey(WidgetKeys.themeButtonKey));
          verify(() => themeCubit.switchThemeMode(ThemeMode.dark)).called(1);
        },
      );
    });
  });
}
