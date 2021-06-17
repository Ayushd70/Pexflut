import 'package:pex_flut/src/models/video.dart';
import 'package:pex_flut/src/models/image.dart';
import 'package:dio/dio.dart';

class AppNetwork {

  static const authorization ='563492ad6f9170000100000156d5de70ea134a2c86369c73c307839c';
  var dio = Dio()
    ..options.headers['Authorization'] = authorization;

  Future<Map<String, dynamic>?> _sendRequest(String url) async {
    try {
      var response = await dio.get(url);
      return response.data;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<Photo>> searchImage(String keyWord, int page) async {
    Map<String, dynamic> data;
    var images = <Photo>[];
    data = (await _sendRequest(
        'https://api.pexels.com/v1/search?query=$keyWord&per_page=15&$page'))!;
    for (Map map in data['photos']) {
      images.add(Photo.fromMap(map));
    }
    return images;
  }

  Future<List<Photo>> curatedImage(int page) async {
    Map<String, dynamic> data;
    var images = <Photo>[];
    data = (await _sendRequest('https://api.pexels.com/v1/curated?page=$page'))!;
    for (Map map in data['photos']) {
      images.add(Photo.fromMap(map));
    }
    return images;
  }

  Future<List<Video>> searchVideo(String keyWord, int page) async {
    Map<String, dynamic> data;
    var videos = <Video>[];
    data = (await _sendRequest(
        'https://api.pexels.com/videos/search?query=$keyWord&page=$page'))!;
    for (Map map in data['videos']) {
      videos.add(Video.fromMap(map));
    }
    return videos;
  }

  Future<List<Video>> popularVideo(int page) async {
    Map<String, dynamic> data;
    var videos = <Video>[];
    data = (await _sendRequest(
        'https://api.pexels.com/videos/popular?per_page=15&page=$page'))!;
    for (Map map in data['videos']) {
      videos.add(Video.fromMap(map));
    }
    return videos;
  }
}


final AppNetwork appNetwork = AppNetwork(); 