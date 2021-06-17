import 'package:equatable/equatable.dart';
import 'package:pex_flut/src/models/image.dart';
import 'package:pex_flut/src/models/video.dart';

abstract class MediaListState extends Equatable {
  final int mediaType;
  MediaListState({required this.mediaType});

  @override
  List<Object> get props => [];
}

class InitialList extends MediaListState {
  final int mediaType;
  InitialList({required this.mediaType}) : super(mediaType: mediaType);
}

class ShowList extends MediaListState {
  final List<Photo> photos;
  final List<Video> videos;
  ShowList({required this.photos, required this.videos, required int mediaType})
      : super(mediaType: mediaType);
}

class Fetching extends MediaListState {
  Fetching(int mediaType) : super(mediaType: mediaType);
}

class FetchingFail extends MediaListState {
  FetchingFail(int mediaType) : super(mediaType: mediaType);
}