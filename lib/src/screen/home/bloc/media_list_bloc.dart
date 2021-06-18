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

  int mediaType = photoCode;
  String keyWord = '';
  List<Photo> photos = [];
  List<Video> videos = [];
  int imagePage = 0;
  int videoPage = 0;

  MediaListBloc() : super(InitialListState());

  @override
  Stream<MediaListState> mapEventToState(MediaListEvent event) async* {
    print(state.runtimeType);
    if (event is FetchDataEvent) {
      yield* _fetchingData(mediaType);
    }
    if (event is MediaTypeChangedEvent) {
      mediaType = event.mediaType;

      yield* _fetchingInitialData(mediaType);
    }
    if (event is SearchSubmitEvent) {
      keyWord = event.keyWord;
      _resetData();

      yield* _fetchingData(mediaType);
    }

    if (event is BackToShowListEvent) {
      keyWord = '';
      _resetData();

      yield* _fetchingData(mediaType);
    }

    if (event is LikedMediaEvent) {
      await mediaRepository.insert(event.media.id);
      print(await mediaRepository.mediaData());
      photos = await checkFavoriteList(photos);
      videos = await checkFavoriteList(videos);
    }
  }

  void _resetData() {
    photos = [];
    videos = [];
    imagePage = 0;
    videoPage = 0;
  }

  Stream<MediaListState> _fetchingData(int mediaType) async* {
    yield FetchingState();
    if (mediaType == photoCode) {
      photos += await mediaRepository.fetchData(
          mediaType: photoCode, page: imagePage + 1, keyWord: keyWord);
      imagePage += 1;
      print('photos.length = ${photos.length}');
    } else {
      videos += await mediaRepository.fetchData(
          mediaType: videoCode, page: videoPage + 1, keyWord: keyWord);
      videoPage += 1;
      print('videos.length = ${videos.length}');
    }
    photos = await checkFavoriteList(photos);
    yield ShowListState(photos: photos, videos: videos, mediaType: mediaType);
  }

  Stream<MediaListState> _fetchingInitialData(int mediaType) async* {
    if (mediaType == photoCode) {
      if (photos.isEmpty) {
        yield FetchingState();
        photos += await mediaRepository.fetchData(
            mediaType: photoCode, page: imagePage + 1, keyWord: keyWord);
        imagePage += 1;
      }
    } else {
      if (videos.isEmpty) {
        yield FetchingState();
        videos += await mediaRepository.fetchData(
            mediaType: videoCode, page: videoPage + 1, keyWord: keyWord);
        videoPage += 1;
      }
    }
    videos = await checkFavoriteList(videos);
    yield ShowListState(photos: photos, videos: videos, mediaType: mediaType);
  }

  Future<List> checkFavoriteList(List mediaList) async {
    for (int i = 0; i < mediaList.length; i++) {
      mediaList[i].liked = await mediaRepository.isContain(mediaList[i].id);
    }
    return mediaList;
  }
}