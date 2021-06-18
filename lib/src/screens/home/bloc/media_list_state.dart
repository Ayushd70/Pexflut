import 'package:pex_flut/src/model/image.dart';
import 'package:pex_flut/src/model/video.dart';
import 'package:equatable/equatable.dart';

abstract class MediaListState extends Equatable {
  const MediaListState();

  @override
  List<Object> get props => [];
}

class MediaListInitialState extends MediaListState {}

class MediaListFailureState extends MediaListState {}

class MediaListSuccessState extends MediaListState {
  final List<Photo> photos;
  final List<Video> videos;
  final bool hasReachedMax;
  final bool restart;

  const MediaListSuccessState(
      {required this.photos, required this.videos, required this.hasReachedMax, required this.restart});

  MediaListSuccessState copyWith(
      {List<Photo>? photos,
        List<Video>? videos,
        bool? hasReachedMax,
        bool? restart}) {
    return MediaListSuccessState(
        photos: photos ?? this.photos,
        videos: videos ?? this.videos,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        restart: restart ?? this.restart);
  }

  @override
  List<Object> get props => [photos, videos, hasReachedMax];
}