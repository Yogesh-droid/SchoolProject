import 'package:flutter/material.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
        headline1: base.headline1.copyWith(
          fontFamily: 'popins',
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Color(0xFF415094),
        ),
        title: base.subtitle1.copyWith(
          fontFamily: 'popins',
          fontSize: 13.0,
          fontWeight: FontWeight.w500,
          color: Color(0xFF415094),
        ),
        display1: base.headline1.copyWith(
            fontFamily: 'popins',
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            color: Color(0xFF727FC8)),
        display2: base.headline1.copyWith(
          fontFamily: 'popins',
          fontSize: 22.0,
          color: Colors.grey,
        ),
        caption: base.caption.copyWith(
          color: Color(0xFFCCC5AF),
        ),
        bodyText1: base.bodyText1.copyWith(color: Color(0xFF807A6B)));
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
      textTheme: _basicTextTheme(base.textTheme),
      //textTheme: Typography().white,
      primaryColor: Colors.indigo,
      //primaryColor: Color(0xff4829b2),
      indicatorColor: Color(0xFF807A6B),
      scaffoldBackgroundColor: Color(0xFFF5F5F5),
      accentColor: Colors.purpleAccent,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 30.0,
      ),
      buttonColor: Colors.white,
      backgroundColor: Colors.white,
      tabBarTheme: base.tabBarTheme.copyWith(
        labelColor: Color(0xffce107c),
        unselectedLabelColor: Colors.grey,
      ));
}
