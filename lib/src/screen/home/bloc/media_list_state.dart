import 'package:equatable/equatable.dart';
import 'package:pex_flut/src/models/image.dart';
import 'package:pex_flut/src/models/video.dart';

abstract class MediaListState extends Equatable {
  MediaListState();

  @override
  List<Object> get props => [];
}

class InitialList extends MediaListState {
  final int mediaType;
  InitialList({required this.mediaType});
}

class ShowList extends MediaListState {
  final List<Photo> photos;
  final List<Video> videos;
  final int mediaType;
  ShowList({required this.photos, required this.videos, required this.mediaType});
}

class Fetching extends MediaListState {
  Fetching();
}

class FetchingFail extends MediaListState {
  FetchingFail();
}