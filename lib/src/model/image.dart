import 'package:equatable/equatable.dart';
import 'image_src.dart';

// ignore: must_be_immutable
class Photo extends Equatable {
  Photo({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.photographer,
    required this.photographerUrl,
    required this.photographerId,
    required this.src,
  });
  final int id;
  final int width;
  final int height;
  final String url;
  final String photographer;
  final String photographerUrl;
  final int photographerId;
  final ImageSrc src;
  bool liked = false;

  factory Photo.fromMap(Map<String, dynamic> map) => Photo(
      id: map['id'],
      width: map['width'],
      height: map['height'],
      url: map['url'],
      photographer: map['photographer'],
      photographerUrl: map['photographer_url'],
      photographerId: map['photographer_id'],
      src: ImageSrc.fromMap(map['src']));

  @override
  List<Object> get props => [
        id,
        width,
        height,
        url,
        photographer,
        photographerUrl,
        photographerId,
        src
      ];

  @override
  String toString() => '''
  id: $id,
  width: $width,
  height: $height,
  url: $url,
  photographer: $photographer,
  photographer_url: $photographerUrl,
  photographer_id: $photographerId,
  src: $src''';
}
