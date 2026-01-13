import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'আখো',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'NotoSansBengali', // বাংলা ফন্ট
      ),
      home: HomeScreen(),
    );
  }
}
