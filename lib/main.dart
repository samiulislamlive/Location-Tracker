import 'package:flutter/material.dart';
import 'package:location_ninja/authentication/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

//initializing for mediaquery
late Size mq;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

