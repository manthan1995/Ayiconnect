import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profile_demo/constant/custom_color.dart';

import '../constant/text_style_decoration.dart';
import '../constant/textfield_decoration.dart';

// ignore: avoid_classes_with_only_static_members
class CustomAppTheme {
  static const int _primaryColor = 0xFF101010;

  static int get primaryColor => _primaryColor;

  static const Color _accentColor = Color(0xFF808080);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: _materialPrimary,
    primaryColor: _materialPrimary,
    colorScheme: const ColorScheme(
      error: Colors.red,
      background: Colors.white,
      brightness: Brightness.light,
      onBackground: Colors.white,
      onError: Colors.red,
      onSecondary: _accentColor,
      primary: Color(_primaryColor),
      onSurface: Colors.white,
      secondary: _accentColor,
      onPrimary: Color(_primaryColor),
      surface: Colors.white,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(_primaryColor),
      disabledColor: Color(0xFFF4F4F4),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey.withOpacity(0.4);
          } else if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          return Colors.grey.withOpacity(0.4);
        },
      ),
    ),
    unselectedWidgetColor: const Color(0xffF4F4F4),
    backgroundColor: Colors.white,
    dividerColor: const Color(0xFFE4E4E4),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE4E4E4),
      thickness: 1,
    ),
    scaffoldBackgroundColor: const Color(0xFFF9F9F9),
    textTheme: TextStyleDecoration.lightTheme,
    primaryTextTheme: TextStyleDecoration.lightTheme,
    inputDecorationTheme: TextFieldDecoration.getOutLineInputDecoration,
    fontFamily: TextStyleDecoration.fontFamily,
    appBarTheme: AppBarTheme(
      systemOverlayStyle: const SystemUiOverlayStyle(),
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: ConstantColor.ffE5E7EB,
      iconTheme: const IconThemeData(color: Colors.white),
      actionsIconTheme: const IconThemeData(
        color: Color(_primaryColor),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 2.0),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(const Size(150.0, 40.0)),
        elevation: MaterialStateProperty.all<double>(0.0),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey.shade400;
            }
            return ConstantColor.ffE5E7EB; // Use the component's default.
          },
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(
          const Size(double.maxFinite, 32.0),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        side: MaterialStateProperty.all<BorderSide>(
          const BorderSide(color: Color(_primaryColor), width: 1.5),
        ),
        textStyle: MaterialStateProperty.all<TextStyle?>(
          TextStyleDecoration.lightTheme.caption?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
          const EdgeInsets.symmetric(horizontal: 5.0),
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(32.0),
            ),
          ),
        ),
      ),
    ),
  );

  //------------------------------ Material Color------------------------//

  static const MaterialColor _materialPrimary = MaterialColor(
    _primaryColor,
    <int, Color>{
      50: Color(_primaryColor),
      100: Color(_primaryColor),
      200: Color(_primaryColor),
      300: Color(_primaryColor),
      400: Color(_primaryColor),
      500: Color(_primaryColor),
      600: Color(_primaryColor),
      700: Color(_primaryColor),
      800: Color(_primaryColor),
      900: Color(_primaryColor),
    },
  );
}
