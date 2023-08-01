import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
      headline6: TextStyle(fontSize: 25.sp, color: Colors.black),
      bodyText1: TextStyle(fontSize: 20.sp, color: Colors.white),
      bodyText2: TextStyle(fontSize: 19.sp, color: Colors.black)),
  backgroundColor: Color(0xfefffcf8),
  brightness: Brightness.light,
  primaryColor: Colors.white,
  primaryColorLight: Color(0xaaaaaaaa),
  primaryColorDark: Colors.amber,
  secondaryHeaderColor: Colors.white70,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.amberAccent, // AppBarの背景色
    elevation: 4, // 影の高さ
    titleTextStyle: TextStyle(fontSize: 22.sp, color: Colors.brown),
    iconTheme: IconThemeData(
      color: Colors.white, // アイコンの色
      size: 25.sp,
    ),
  ),
  dialogTheme: DialogTheme(backgroundColor: Colors.white),
);

ThemeData darkTheme = ThemeData(
  textTheme: TextTheme(
      headline6: TextStyle(fontSize: 25.sp, color: Color(0xeeeeeeee)),
      bodyText1: TextStyle(fontSize: 20.sp, color: Colors.black),
      bodyText2: TextStyle(fontSize: 19.sp, color: Color(0xeeeeeeee))),
  backgroundColor: Colors.black,
  // ライトモードのカラーパレット
  brightness: Brightness.light,
  primaryColor: Color(0x33333333),
  primaryColorLight: Color(0xdddddddd),
  primaryColorDark: Colors.amber,
    secondaryHeaderColor: Colors.black87,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.amberAccent, // AppBarの背景色
    elevation: 4, // 影の高さ
    titleTextStyle: TextStyle(fontSize: 22.sp, color: Colors.brown),
    iconTheme: IconThemeData(
      color: Colors.white, // アイコンの色
      size: 25.sp,
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.black,
  ),
);
