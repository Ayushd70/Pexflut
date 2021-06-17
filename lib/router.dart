import 'package:pex_flut/src/screen/home/screen/home_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'src/screen/media_details/media_details-screen.dart';

class FluroRouter {
  static Router router = Router();

  static Handler _homeHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          HomeScreen());
  static Handler _mediaDetailHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          MediaDetail());
  static void setupRouter() {
    router.define('home', handler: _homeHandler);
    router.define('mediaDetail', handler: _mediaDetailHandler);
  }
}