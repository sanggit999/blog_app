import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _boder([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20.0),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
    ),
    // chipTheme: const ChipThemeData(
    //   color: MaterialStatePropertyAll(AppPallete.backgroundColor),
    //   side: BorderSide.none,
    // ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27.0),
      border: _boder(),
      enabledBorder: _boder(),
      focusedBorder: _boder(AppPallete.gradient2),
      errorBorder: _boder(AppPallete.errorColor),
    ),
  );
}
