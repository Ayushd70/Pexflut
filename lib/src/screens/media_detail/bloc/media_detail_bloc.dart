import 'package:pex_flut/resource/resources.dart';
import 'package:pex_flut/src/data/repository/media_repository.dart';
import 'package:pex_flut/src/model/image.dart';
import 'package:pex_flut/src/model/video.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'media_detail_event.dart';
import 'media_detail_state.dart';

class MediaDetailBloc extends Bloc<MediaDetailEvent, MediaDetailState> {
  MediaDetailBloc() : super(InitialMediaDetailState());
  MediaRepository mediaRepository = MediaRepository();

  @override
  Stream<MediaDetailState> mapEventToState(MediaDetailEvent event) async* {
    if (event is LikedEvent) {
      if (await mediaRepository.isContain(event.mediaTypeCode, event.mediaID)) {
        await mediaRepository.delete(event.mediaTypeCode, event.mediaID);
      } else {
        await mediaRepository.insert(event.mediaTypeCode, event.mediaID);
      }
    }
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
