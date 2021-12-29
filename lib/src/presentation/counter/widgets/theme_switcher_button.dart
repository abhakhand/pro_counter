import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_counter/src/application/theme/theme_cubit.dart';
import 'package:pro_counter/src/presentation/core/helpers/widget_keys.dart';

class ThemeSwitcherButton extends StatelessWidget {
  const ThemeSwitcherButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        final cubit = context.read<ThemeCubit>();
        final isDarkMode = themeMode == ThemeMode.dark;

        return IconButton(
          key: WidgetKeys.themeButtonKey,
          icon: Icon(
            isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          ),
          onPressed: () {
            if (isDarkMode) {
              cubit.switchThemeMode(ThemeMode.light);
            } else {
              cubit.switchThemeMode(ThemeMode.dark);
            }
          },
        );
      },
    );
  }
}
