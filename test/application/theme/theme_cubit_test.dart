import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pro_counter/src/application/theme/theme_cubit.dart';

import '../../helpers/helpers.dart';

void main() {
  group('ThemeCubit', () {
    late ThemeCubit themeCubit;

    setUp(() {
      mockHydratedStorage(() {
        themeCubit = ThemeCubit();
      });
    });

    tearDown(() {
      themeCubit.close();
    });

    test('initial state is correct', () {
      expect(themeCubit.state, ThemeMode.dark);
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        expect(
          themeCubit.fromJson(themeCubit.toJson(themeCubit.state)),
          themeCubit.state,
        );
      });
    });

    blocTest<ThemeCubit, ThemeMode>(
      'emits [Dark/Light Mode] when update is called.',
      build: () => mockHydratedStorage(ThemeCubit.new),
      act: (cubit) => cubit.switchThemeMode(ThemeMode.dark),
      expect: () => [equals(ThemeMode.dark)],
    );
  });
}
