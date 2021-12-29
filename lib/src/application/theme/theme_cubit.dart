import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.dark);

  void switchThemeMode(ThemeMode themeMode) => emit(themeMode);

  @override
  ThemeMode fromJson(Map<String, dynamic> json) =>
      _mapStringToThemeMode(json['value'] as String);

  @override
  Map<String, dynamic> toJson(ThemeMode state) => <String, dynamic>{
        'value': state.toString(),
      };
}

ThemeMode _mapStringToThemeMode(String value) {
  if (value == 'ThemeMode.light') {
    return ThemeMode.light;
  } else {
    return ThemeMode.dark;
  }
}
