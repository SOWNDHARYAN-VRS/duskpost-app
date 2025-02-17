import 'package:duskpost_app/navigation/nav_bar.dart';
import 'package:duskpost_app/themes/dark_theme.dart';
import 'package:duskpost_app/themes/light_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DuskPost',
      themeMode: ThemeMode.system,
      theme:LightTheme.lightTheme,
      darkTheme: DarkTheme.darkTheme,
      home: DuskPostNavigationBar(),
    );
  }
}
