import 'package:equatable/equatable.dart';
import 'package:pex_flut/src/models/image.dart';
import 'package:pex_flut/src/models/video.dart';

abstract class MediaListEvent extends Equatable {
  MediaListEvent();
}

class MediaTypeChanged extends MediaListEvent {
  final int mediaType;
  MediaTypeChanged({required this.mediaType});

  @override
  List<Object> get props => [mediaType];
}

class ChoosePhoto extends MediaListEvent {
  final Photo photo;
  ChoosePhoto({required this.photo});

  @override
  List<Object> get props => [photo];
}

class ChooseVideo extends MediaListEvent {
  final Video video;
  ChooseVideo({required this.video});

  @override
  List<Object> get props => [video];
}

class FetchData extends MediaListEvent {
  FetchData();

  @override
  List<Object> get props => [];
}