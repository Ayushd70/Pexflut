import 'package:pex_flut/src/screens/home/screen/home_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class FluroRouter {
  static Router router = Router();

  static Handler _homeHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          HomeScreen());
  static Handler _mediaDetailHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          MediaDetailScreen(params['mediaType'][0], params['mediaKey'][0]));
  static void setupRouter() {
    router.define('home', handler: _homeHandler);
    router.define('mediaDetail/:mediaType/:mediaKey',
        handler: _mediaDetailHandler);
  }
}
