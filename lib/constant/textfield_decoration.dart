import 'package:flutter/material.dart';

import '../../constant/custom_color.dart';
import '../../constant/text_style_decoration.dart';

class TextFieldDecoration {
  static BorderRadius get textBorderRadius => BorderRadius.circular(8.0);
  static Color get borderColor => ConstantColor.ffE5E7EB;

  static Color get outLineInputBorderColor => Colors.grey.withOpacity(0.35);
  static double get borderWidth => 1.0;

  static const EdgeInsetsGeometry _contentPadding = EdgeInsets.only(
    bottom: 0.0,
    right: 12.0,
    left: 12.0,
  );

  // UnderLine border...
  static InputDecorationTheme get getOutLineInputDecoration =>
      InputDecorationTheme(
        errorMaxLines: 2,
        filled: true,
        fillColor: Colors.transparent,
        focusColor: Colors.transparent,
        hintStyle: TextStyleDecoration.hintTextStyle,
        labelStyle: TextStyleDecoration.labelTextStyle,
        errorStyle: TextStyleDecoration.errorStyle,
        focusedErrorBorder: _outlineFocusedErrorBorder,
        errorBorder: _outlineFocusedErrorBorder,
        focusedBorder: _outlineFocusedBorder,
        border: _outlineBorder,
        enabledBorder: _outlineEnableBorder,
        disabledBorder: _outlineDisabledBorder,
        contentPadding: _contentPadding,
      );

  static OutlineInputBorder get _outlineDisabledBorder => OutlineInputBorder(
        borderRadius: textBorderRadius,
        borderSide: BorderSide(
          color: outLineInputBorderColor,
          width: borderWidth,
        ),
      );

  static OutlineInputBorder get _outlineFocusedBorder => OutlineInputBorder(
        borderRadius: textBorderRadius,
        borderSide: BorderSide(
          color: Colors.black87,
          width: borderWidth,
        ),
      );

  static OutlineInputBorder get _outlineEnableBorder => OutlineInputBorder(
        borderRadius: textBorderRadius,
        borderSide: BorderSide(
          color: outLineInputBorderColor,
          width: borderWidth,
        ),
      );
  static OutlineInputBorder get _outlineBorder => OutlineInputBorder(
        borderRadius: textBorderRadius,
        borderSide: BorderSide(
          color: outLineInputBorderColor,
          width: borderWidth,
        ),
      );

  static OutlineInputBorder get _outlineFocusedErrorBorder =>
      OutlineInputBorder(
        borderRadius: textBorderRadius,
        borderSide: BorderSide(
          color: Colors.red,
          width: borderWidth,
        ),
      );
}
