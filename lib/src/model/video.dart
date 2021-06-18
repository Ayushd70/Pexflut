import 'video_file.dart';
import 'video_picture.dart';
import 'video_user.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Video extends Equatable {
  Video(
      {this.id,
        this.width,
        this.height,
        this.url,
        this.image,
        this.duration,
        this.user,
        this.videoFiles,
        this.videoPictures});

  final int id;
  final int width;
  final int height;
  final String url;
  final String image;
  final int duration;
  final VideoUser user;
  final List<VideoFile> videoFiles;
  final List<VideoPicture> videoPictures;
  bool liked = false;

  factory Video.fromMap(Map<String, dynamic> map) {
    var files = <VideoFile>[];
    var pictures = <VideoPicture>[];
    for (Map file in map['video_files']) {
      files.add(VideoFile.fromMap(file));
    }
    for (Map picture in map['video_pictures']) {
      pictures.add(VideoPicture.fromMap(picture));
    }
    return Video(
        id: map['id'],
        width: map['width'],
        height: map['height'],
        url: map['url'],
        image: map['image'],
        duration: map['duration'],
        user: VideoUser.fromMap(map['user']),
        videoFiles: files,
        videoPictures: pictures);
  }

  @override
  List<Object> get props => [
    id,
    width,
    height,
    url,
    image,
    duration,
    user,
    videoFiles,
    videoPictures
  ];

  @override
  String toString() => '''
  id: $id,
  width: $width,
  height: $height,
  url: $url,
  image: $image,
  duration:$duration,
  user: $user,
  video_files: $videoFiles,
  video_pictures: $videoPictures
  ''';
}