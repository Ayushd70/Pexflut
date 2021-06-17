import 'package:pex_flut/src/models/image.dart';
import 'package:pex_flut/src/models/video.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pex_flut/src/data/repository/media_repository.dart';
import '../../../data/repository/media_repository.dart';
import 'media_list_event.dart';
import 'media_list_state.dart';

const photoCode = 0;
const videoCode = 1;

class MediaListBloc extends Bloc<MediaListEvent, MediaListState> {
  MediaRepository mediaRepository = MediaRepository();

  int mediaType;
  List<Photo> photos = [];
  List<Video> videos = [];
  int imagePage = 0;
  int videoPage = 0;
  String keyWord = '';

  MediaListBloc() : super(InitialList(mediaType: photoCode));

  @override
  Stream<MediaListState> mapEventToState(MediaListEvent event) async* {
    if (event is FetchData) {
      yield Fetching();
      if (mediaType == photoCode) {
        photos += await mediaRepository.fetchData(
            mediaType: photoCode, page: imagePage + 1, keyWord: keyWord);
        imagePage += 1;
      } else {
        videos += await mediaRepository.fetchData(
            mediaType: videoCode, page: videoPage + 1, keyWord: keyWord);
        videoPage += 1;
      }
      print('photos.length = ${photos.length}');
      print('videos.length = ${videos.length}');
      yield ShowList(photos: photos, videos: videos, mediaType: mediaType);
    }
    if (event is MediaTypeChanged) {
      mediaType = event.mediaType;
      yield ShowList(photos: photos, videos: videos, mediaType: mediaType);
    }
  }
}