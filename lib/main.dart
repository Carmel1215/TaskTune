import 'package:flutter/material.dart';
import 'package:tasktune/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
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

    final darkScheme = const ColorScheme(
      // TODO: 엉망진창 색깔 고치기
      brightness: Brightness.dark,
      primary: Color.fromARGB(255, 255, 111, 0),
      onPrimary: Colors.white,
      secondary: Color.fromARGB(255, 255, 111, 0),
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.black,
      onSurface: Colors.white,
    );

    final darkText = ThemeData(useMaterial3: true).textTheme
        .apply(); // TODO: apply는 전체 적용, copyWith은 하나의 스타일씩 적용이니까 잘 생각해서 GPT한테 물어봐가면서 스타일 수정하기

    return MaterialApp(
      home: const HomeScreen(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightScheme,
        textTheme: lightText,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
          foregroundColor: lightScheme.onPrimary,
          backgroundColor: lightScheme.primary,
          shadowColor: Colors.black,
          elevation: 5,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: darkScheme,
        textTheme: darkText,
      ),
      themeMode: ThemeMode.light,
    );
  }
}
