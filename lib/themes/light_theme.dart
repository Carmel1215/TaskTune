import 'package:flutter/material.dart';

final lightScheme = const ColorScheme(
  brightness: Brightness.light,
  primary: Color.fromARGB(255, 239, 123, 0), // 북일 대표 색 1
  onPrimary: Colors.white,
  secondary: Color.fromARGB(255, 243, 150, 51), // 북일 대표 색 2
  onSecondary: Colors.white,
  tertiary: Color.fromARGB(255, 247, 191, 127), // 북일 대표 색 3
  onTertiary: Colors.black,
  error: Colors.red,
  onError: Colors.white,
  surface: Color.fromARGB(255, 255, 255, 255),
  onSurface: Colors.black,
);

final lightText = ThemeData(useMaterial3: true).textTheme
    .apply(); // TODO: apply는 전체 적용, copyWith은 하나의 스타일씩 적용이니까 잘 생각해서 GPT한테 물어봐가면서 스타일 수정하기
