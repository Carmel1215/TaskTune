import 'package:flutter/material.dart';
import 'package:tasktune/themes/light_theme.dart';
import 'package:tasktune/themes/dark_theme.dart';
import 'package:tasktune/widgets/app_scaffold.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AppScaffold(),
      theme: ThemeData(
        useMaterial3: true,
        splashFactory: NoSplash.splashFactory,
        colorScheme: lightScheme,
        textTheme: lightText,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.black,
          elevation: 3,
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
