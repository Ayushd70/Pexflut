import 'package:pex_flut/resource/resources.dart';
import '../../model/video.dart';
import '../../model/image.dart';
import 'package:dio/dio.dart';

class AppNetwork {
  static const authorization = apiKey1;
  final Dio dio = Dio()..options.headers['Authorization'] = authorization;

  Future<Map<String, dynamic>> _sendRequest(String url) async {
    try {
      var response = await dio.get(url);
      return response.data;
    } catch (e) {
      print(e);
    }
    return {};
  }

  Future<List<Photo>> searchImage(String keyWord, int page) async {
    Map<String, dynamic> data;
    var images = <Photo>[];
    data = await _sendRequest(
        'https://api.pexels.com/v1/search?query=$keyWord&per_page=$per_page&page=$page');
    for (Map<String, dynamic> map in data['photos']) {
      images.add(Photo.fromMap(map));
    }
    return images;
  }

  Future<List<Photo>> curatedImage(int page) async {
    Map<String, dynamic> data;
    var images = <Photo>[];
    data = await _sendRequest(
        'https://api.pexels.com/v1/curated?per_page=$per_page&page=$page');
    for (Map<String, dynamic> map in data['photos']) {
      images.add(Photo.fromMap(map));
    }
    return images;
  }

  Future<List<Video>> searchVideo(String keyWord, int page) async {
    Map<String, dynamic> data;
    var videos = <Video>[];
    data = await _sendRequest(
        'https://api.pexels.com/videos/search?query=$keyWord&per_page=$per_page&page=$page');
    for (Map<String, dynamic> map in data['videos']) {
      videos.add(Video.fromMap(map));
    }
    return videos;
  }

  Future<List<Video>> popularVideo(int page) async {
    Map<String, dynamic> data;
    var videos = <Video>[];
    data = await _sendRequest(
        'https://api.pexels.com/videos/popular?per_page=$per_page&page=$page');
    for (Map<String, dynamic> map in data['videos']) {
      videos.add(Video.fromMap(map));
    }
    return videos;
  }

  Future<Photo> getImage(String imageKey) async {
    Map<String, dynamic> data;
    data = await _sendRequest('https://api.pexels.com/v1/photos/$imageKey');
    Photo photo = Photo.fromMap(data);
    return photo;
  }

  Future<Video> getVideo(String videoKey) async {
    Map<String, dynamic> data;
    data = await _sendRequest('https://api.pexels.com/videos/videos/$videoKey');
    Video video = Video.fromMap(data);
    return video;
  }
}

final AppNetwork appNetwork = AppNetwork();
