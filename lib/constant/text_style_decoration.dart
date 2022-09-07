import 'package:flutter/material.dart';

import '../../constant/custom_color.dart';
import '../../constant/custom_font.dart';
import '../../constant/custom_theme.dart';

// overline : 10.0
// caption  : 12.0
// bodytext1: 14.0
// bodytext2: 16.0
// headline1: 18.0
// headline2: 20.0
// headline3: 22.0
// headline4: 24.0
// headline5: 26.0
// headline6: 28.0

// W100 - thin,
// W200 - extra light.
// W300 - light,
// W400 - normal, regular plain,
// W500 - medium,
// W600 - semi-bold,
// W700 - bold,
// W800 - extra bold,
// W900 - black, ,most thick.

class TextStyleDecoration {
  // App Default font...
  static const String fontFamily = CustomFont.defaultFontFamily;

  static Color fontColor = Color(CustomAppTheme.primaryColor);

  static const TextStyle errorStyle = TextStyle(
    fontFamily: TextStyleDecoration.fontFamily,
    color: Colors.red,
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
  );

  static TextStyle hintTextStyle = TextStyle(
    color: ConstantColor.ffAEAEAE,
    fontSize: 16.0,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle labelTextStyle = TextStyle(
    color: fontColor,
    fontFamily: fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  // Get Text theme...
  static TextTheme get lightTheme => TextTheme(
        overline: _overline, // 10.0
        caption: _caption, // 12.0
        bodyText1: _body1, // 14.0
        bodyText2: _body2, // 16.0
        headline1: _headline1, // 18.0
        headline2: _headline2, // 20.0
        headline3: _headline3, // 22.0
        headline4: _headline4, // 24.0
        headline5: _headline5, // 26.0
        headline6: _headline6, // 28.0
        subtitle1:
            _subTitle, // 16.0 this is also used when no style is given to textfield..
        subtitle2: _subHeadline, // 16.0
        button: _button, // 16.0
      );

  static final _overline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10.0,
    color: fontColor,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
  );

  static final _caption = TextStyle(
    fontFamily: fontFamily,
    color: fontColor,
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle _body1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.0,
    color: fontColor,
    fontWeight: FontWeight.w400,
  );

  static final _body2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.0,
    color: fontColor,
    fontWeight: FontWeight.w400,
  );

  static final _headline1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18.0,
    color: fontColor,
    fontWeight: FontWeight.w400,
  );

  static final _headline2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.0,
    color: fontColor,
    fontWeight: FontWeight.w400,
  );

  static final _headline3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22.0,
    color: fontColor,
    fontWeight: FontWeight.w400,
  );

  static final _headline4 = TextStyle(
    fontFamily: fontFamily,
    color: fontColor,
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
  );

  static final _headline5 = TextStyle(
    fontFamily: fontFamily,
    color: fontColor,
    fontSize: 26.0,
    fontWeight: FontWeight.w400,
  );

  static final _headline6 = TextStyle(
    fontFamily: fontFamily,
    color: fontColor,
    fontSize: 28.0,
    fontWeight: FontWeight.w400,
  );

  static final _subTitle = TextStyle(
    color: fontColor,
    fontFamily: fontFamily,
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
  );

  static final _subHeadline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.0,
    color: fontColor,
    fontWeight: FontWeight.w400,
  );

  static final _button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.0,
    letterSpacing: 3,
    color: fontColor,
    fontWeight: FontWeight.w600,
  );
}
