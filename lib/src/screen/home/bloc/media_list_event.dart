import 'package:equatable/equatable.dart';
import 'package:pex_flut/src/models/image.dart';
import 'package:pex_flut/src/models/video.dart';

abstract class MediaListEvent extends Equatable {
  MediaListEvent();
}

class InitialMediaEvent extends MediaListEvent {
  InitialMediaEvent();
  @override
  List<Object> get props => [];
}

class MediaTypeChangedEvent extends MediaListEvent {
  final int mediaType;
  MediaTypeChangedEvent({required this.mediaType});

  @override
  List<Object> get props => [mediaType];
}

class ChoosePhotoEvent extends MediaListEvent {
  final Photo photo;
  ChoosePhotoEvent({required this.photo});

  @override
  List<Object> get props => [photo];
}

class ChooseVideoEvent extends MediaListEvent {
  final Video video;
  ChooseVideoEvent({required this.video});

  @override
  List<Object> get props => [video];
}

class FetchDataEvent extends MediaListEvent {
  FetchDataEvent();

  @override
  List<Object> get props => [];
}

class SearchSubmitEvent extends MediaListEvent {
  final String keyWord;
  SearchSubmitEvent({required this.keyWord});
  @override
  List<Object> get props => [keyWord];
}

class BackToShowListEvent extends MediaListEvent {
  BackToShowListEvent();
  @override
  List<Object> get props => [];
}

class LikedMediaEvent extends MediaListEvent {
  final media;
  LikedMediaEvent({this.media});
  @override
  List<Object> get props => [media];
}