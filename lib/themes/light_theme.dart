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

  surface: Color(0xFFFAF9F6), // 기준 surface
  surfaceContainerLowest: Color(0xFFFFFDFB), // 가장 밝음, 주황기 살짝
  surfaceContainerLow: Color(0xFFF7F4F0), // 약간 어두움, 따뜻한 베이지
  surfaceContainer: Color(0xFFF0ECE7), // 중간 톤, 주황빛 유지
  surfaceContainerHigh: Color(0xFFE8E3DE), // 더 어두움, 베이지 회색
  surfaceContainerHighest: Color(0xFFE0DAD5), // 가장 어둡게, 부드러운 브라운 기
  onSurface: Colors.black,
);

final lightText = ThemeData(useMaterial3: true).textTheme
    .apply(); // TODO: apply는 전체 적용, copyWith은 하나의 스타일씩 적용이니까 잘 생각해서 GPT한테 물어봐가면서 스타일 수정하기
