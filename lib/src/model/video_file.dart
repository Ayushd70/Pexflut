import 'package:equatable/equatable.dart';

class VideoFile extends Equatable {
  VideoFile(
      {this.id,
        this.quality,
        this.fileType,
        this.width,
        this.height,
        this.link});
  final int id;
  final String quality;
  final String fileType;
  final int width;
  final int height;
  final String link;

  factory VideoFile.fromMap(Map<String, dynamic> map) => VideoFile(
      id: map['id'],
      quality: map['quality'],
      fileType: map['file_type'],
      width: map['width'],
      height: map['height'],
      link: map['link']);

  @override
  List<Object> get props => [id, quality, fileType, width, height, link];

  @override
  String toString() => '''
  id: $id,
  quality: $quality,
  file_type: $fileType,
  width: $width,
  height: $height,
  link: $link
  ''';
}