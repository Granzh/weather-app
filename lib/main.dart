import 'package:flutter/material.dart';

import 'package:untitled/pages/weather_page.dart';
import 'package:untitled/theme/theme.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app',
      theme: ThemeData(useMaterial3: true),
      darkTheme: darkMode,
      debugShowCheckedModeBanner: false,
      home: const WeatherPage()
    );
  }
}

