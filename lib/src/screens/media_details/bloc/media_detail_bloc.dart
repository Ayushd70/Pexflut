import 'package:pex_flut/src/data/repository/media_repository.dart';
import 'package:pex_flut/src/model/image.dart';
import 'package:pex_flut/src/model/video.dart';
import 'package:pex_flut/src/screens/home/bloc/media_list_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MediaDetailEvent {
  MediaDetailEvent();
}

class InitialMediaDetailEvent extends MediaDetailEvent {
  final String mediaType;
  final String mediaKey;
  InitialMediaDetailEvent({required this.mediaType, required this.mediaKey});
}

class LikedEvent extends MediaDetailEvent {
  final media;
  LikedEvent({this.media});
}

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
      {required this.mediaType,
        required this.photo,
        required this.video,
        required this.relatedPhoto,
        required this.relatedVideo});
}

class MediaDetailBloc extends Bloc<MediaDetailEvent, MediaDetailState> {
  MediaDetailBloc() : super(InitialMediaDetailState());
  MediaRepository mediaRepository = MediaRepository();

  @override
  Stream<MediaDetailState> mapEventToState(MediaDetailEvent event) async* {
    if (event is LikedEvent) {}

    if (event is InitialMediaDetailEvent) {
      yield LoadingMediaState();
      if (event.mediaType == '$photoCode') {
        Photo photo = await mediaRepository.getImage(event.mediaKey);
        List<Photo> relatedPhoto = await mediaRepository.relatedImage(photo);
        yield ShowMediaState(
            mediaType: photoCode, photo: photo, relatedPhoto: relatedPhoto);
      } else {
        Video video = await mediaRepository.getVideo(event.mediaKey);
        List<Video> relatedVideo = await mediaRepository.relatedVideo(video);
        yield ShowMediaState(
            mediaType: videoCode, video: video, relatedVideo: relatedVideo);
      }
    }
  }
}