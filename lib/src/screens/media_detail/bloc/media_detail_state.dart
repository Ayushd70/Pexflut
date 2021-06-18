import 'package:pex_flut/src/model/image.dart';
import 'package:pex_flut/src/model/video.dart';
import 'package:equatable/equatable.dart';

abstract class MediaDetailState extends Equatable {
  MediaDetailState();
  @override
  List<Object> get props => [];
}

class InitialMediaDetailState extends MediaDetailState {
  InitialMediaDetailState();
}

class LoadingMediaState extends MediaDetailState {
  LoadingMediaState();
}

class LoadingFailMediaState extends MediaDetailState {
  LoadingFailMediaState();
}

class ShowMediaState extends MediaDetailState {
  final int mediaType;
  final Photo photo;
  final Video video;
  final List<Photo> relatedPhoto;
  final List<Video> relatedVideo;
  ShowMediaState(
      {this.mediaType,
        this.photo,
        this.video,
        this.relatedPhoto,
        this.relatedVideo});
}