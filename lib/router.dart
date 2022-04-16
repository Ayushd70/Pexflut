import 'package:pex_flut/src/screens/favorite/screen/favorite_screen.dart';

import 'src/screens/home/screen/home_screen.dart';
import 'src/screens/media_detail/screen/media_details-screen.dart';
import 'package:fluro/fluro.dart' as fl;

class FluroRouter {
  static fl.FluroRouter router = fl.FluroRouter.appRouter;

  static fl.Handler _homeHandler = fl.Handler(
      handlerFunc: (context, Map<String, dynamic> params) => HomeScreen());
  static fl.Handler _mediaDetailHandler = fl.Handler(
      handlerFunc: (context, Map<String, dynamic> params) =>
          MediaDetailScreen(params['mediaType'][0], params['mediaKey'][0]));
  static fl.Handler _favoriteHandler = fl.Handler(
      handlerFunc: (context, Map<String, dynamic> params) => FavoriteScreen());

  static void setupRouter() {
    router.define('home', handler: _homeHandler);
    router.define('mediaDetail/:mediaType/:mediaKey',
        handler: _mediaDetailHandler);
    router.define('favorite', handler: _favoriteHandler);
  }
}
