import 'package:covid19_tracking_app/view/splash_screen.dart';
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
      home: Scaffold(
        appBar: AppBar(
          title: Text('Covid 19 Tracking App', style: TextStyle(color: Colors.white),),
          backgroundColor: Color(0xff179BAE),
          centerTitle: true,
        ),
        backgroundColor: Colors.grey,
        body: SplashScreen(),
      ),
    );
  }
}

