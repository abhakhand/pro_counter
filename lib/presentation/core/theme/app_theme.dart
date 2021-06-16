import 'package:flutter/material.dart';

class AppTheme {
  static const Color _primaryColorLight = Color(0xff00b4d8);
  static const Color _primaryColorDark = Color(0xff8e94f2);

  static ThemeData get light => ThemeData.light().copyWith(
        primaryColor: _primaryColorLight,
        accentColor: _primaryColorLight,
      );

  static ThemeData get dark => ThemeData.dark().copyWith(
        primaryColor: _primaryColorDark,
        accentColor: _primaryColorDark,
      );
}
