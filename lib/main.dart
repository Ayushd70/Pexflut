import 'package:pex_flut/router.dart';
import 'package:flutter/material.dart';

void main() {
  FluroRouter.setupRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PexFlut',
      initialRoute: 'home',
      onGenerateRoute: FluroRouter.router.generator,
    );
  }
}