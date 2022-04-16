import 'package:pex_flut/router.dart';
import 'package:flutter/material.dart';
import 'package:pex_flut/themes.dart';

void main() {
  FluroRouter.setupRouter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      title: 'PexFlut',
      initialRoute: 'home',
      onGenerateRoute: FluroRouter.router.generator,
    );
  }
}
