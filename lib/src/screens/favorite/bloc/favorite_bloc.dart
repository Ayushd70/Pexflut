import 'package:pex_flut/resource/resources.dart';
import 'package:pex_flut/src/data/repository/media_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'favorite_event.dart';
import 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitialState());

  MediaRepository mediaRepository = MediaRepository();

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is DislikeEvent) {
      await mediaRepository.delete(event.mediaTypeCode, event.mediaID);
      print('deteted');
    }
    if (event is FavoriteFetchEvent) {
      try {
        var data = await mediaRepository.mediaData();
        List mediaList = [];
        for (int i = 0; i < data.length; i++) {
          if (data[i][0] == photoCode) {
            var media = await mediaRepository.getImage('${data[i][1]}');
            mediaList.add(media);
          } else {
            var media = await mediaRepository.getVideo('${data[i][1]}');
            mediaList.add(media);
          }
        }

        yield FavoriteSuccessState(mediaList: mediaList);
      } catch (_) {
        yield FavoriteFailureState();
      }
    }
  }
}
