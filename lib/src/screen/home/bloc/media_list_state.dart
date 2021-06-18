import 'package:equatable/equatable.dart';
import 'package:pex_flut/src/models/image.dart';
import 'package:pex_flut/src/models/video.dart';

abstract class MediaListState extends Equatable {
  MediaListState();

  @override
  List<Object> get props => [];
}

class InitialListState extends MediaListState {}

class ShowListState extends MediaListState {
  final List<Photo> photos;
  final List<Video> videos;
  final int mediaType;
  ShowListState({required this.photos, required this.videos, required this.mediaType});
}

class FetchingState extends MediaListState {
  FetchingState();
}

class FetchingFailState extends MediaListState {
  FetchingFailState();
}