import 'package:flutter/material.dart';
import 'package:pex_flut/src/screen/home/screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PexFlut',
      home: HomeScreen(),
    );
  }
}