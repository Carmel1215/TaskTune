import 'package:flutter/material.dart';

final darkScheme = const ColorScheme(
  // TODO: 엉망진창 색깔 고치기
  brightness: Brightness.dark,
  primary: Color.fromARGB(255, 255, 111, 0),
  onPrimary: Colors.white,
  secondary: Color.fromARGB(255, 255, 111, 0),
  onSecondary: Colors.white,
  tertiary: Colors.amber,
  onTertiary: Colors.amberAccent,
  error: Colors.red,
  onError: Colors.white,
  surface: Colors.black,
  onSurface: Colors.white,
);

final darkText = ThemeData(useMaterial3: true).textTheme
    .apply(); // TODO: apply는 전체 적용, copyWith은 하나의 스타일씩 적용이니까 잘 생각해서 GPT한테 물어봐가면서 스타일 수정하기
