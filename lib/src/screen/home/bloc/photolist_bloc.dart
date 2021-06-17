import 'package:pex_flut/src/models/image.dart';
import 'package:pex_flut/src/models/video.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pex_flut/src/data/repository/media_repository.dart';
import 'photolist_event.dart';
import 'photolist_state.dart';

class PhotoListBloc extends Bloc<PhotoListEvent, PhotoListState> {

  MediaRepository mediaRepository = MediaRepository();

  MediaType mediaType;
  List<Photo> images = [];
  List<Video> videos = [];

  PhotoListBloc() : super(InitialList(status: 'Image'));

  @override
  Stream<PhotoListState> mapEventToState(PhotoListEvent event) async* {

    if (event is FetchData) {
      yield Fetching(_getStatus(mediaType));
      if (event.status == MediaType.image) {
        images = await mediaRepository.fetchData(MediaType.image, 1, event.keyWord);
      } else {
        videos = await mediaRepository.fetchData(MediaType.video, 1, event.keyWord);
      }
      yield ShowList(
          photos: images, videos: videos, status: _getStatus(mediaType));
    }
    if (event is StatusChanged) {
      yield ShowList(
          photos: images, videos: videos, status: _getStatus(mediaType));
    }
  }
  String _getStatus(MediaType status) =>
      status == MediaType.image ? 'Image' : 'Video';
}