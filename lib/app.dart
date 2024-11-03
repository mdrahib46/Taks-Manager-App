import 'package:flutter/material.dart';
import 'package:task_manager/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: TaskManagerApp.navigatorKey,
      theme: ThemeData(
          colorSchemeSeed: Colors.green,
          inputDecorationTheme: _inputDecorationTheme(),
          elevatedButtonTheme: _elevatedButtonThemeData(),
          floatingActionButtonTheme: _buildFloatingActionTheme()),
      home: const SplashScreen(),
    );
  }

  FloatingActionButtonThemeData _buildFloatingActionTheme() {
    return FloatingActionButtonThemeData(
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
    );
  }

  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        fixedSize: const Size.fromWidth(double.maxFinite),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: Colors.grey, letterSpacing: 1.2),
        labelStyle: const TextStyle(color: Colors.green),
        prefixIconColor: Colors.green.shade800,
        enabledBorder: _inputBorder(),
        focusedBorder: _inputBorder(),
        border: _inputBorder());
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white));
  }
}
