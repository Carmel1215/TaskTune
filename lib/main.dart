import 'package:flutter/material.dart';
import 'package:tasktune/screens/home_screen.dart';
import 'package:tasktune/themes/light_theme.dart';
import 'package:tasktune/themes/dark_theme.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
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
        useMaterial3: true,
        colorScheme: darkScheme,
        textTheme: darkText,
      ),
      themeMode: ThemeMode.light,
    );
  }
}
