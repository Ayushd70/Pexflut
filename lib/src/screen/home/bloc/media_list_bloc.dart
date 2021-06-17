import 'package:pex_flut/src/models/image.dart';
import 'package:pex_flut/src/models/video.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pex_flut/src/data/repository/media_repository.dart';
import '../../../data/repository/media_repository.dart';
import 'media_list_event.dart';
import 'media_list_state.dart';

const imageCode = 0;
const videoCode = 1;

class MediaListBloc extends Bloc<MediaListEvent, MediaListState> {
  MediaRepository mediaRepository = MediaRepository();

  int mediaType;
  List<Photo> photos = [];
  List<Video> videos = [];

  MediaListBloc() : super(InitialList(mediaType: imageCode));

  @override
  Stream<MediaListState> mapEventToState(MediaListEvent event) async* {
    if (event is FetchData) {
      yield Fetching(mediaType);
      if (event.mediaType == imageCode) {
        photos = await mediaRepository.fetchData(
            mediaType: imageCode, page: 1, keyWord: event.keyWord);
      } else {
        videos = await mediaRepository.fetchData(
            mediaType: videoCode, page: 1, keyWord: event.keyWord);
      }
      yield ShowList(photos: photos, videos: videos, mediaType: mediaType);
      // print('$photos');
      // print('$videos');
    }
    if (event is StatusChanged) {
      yield ShowList(photos: photos, videos: videos, mediaType: mediaType);
    }
  }
}