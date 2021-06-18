import 'package:pex_flut/src/data/repository/media_repository.dart';
import 'package:pex_flut/src/screens/home/bloc/media_list_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FavoriteEvent {}

class FavoriteFetchEvent extends FavoriteEvent {}

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitialState extends FavoriteState {}

class FavoriteFailureState extends FavoriteState {}

class FavoriteSuccessState extends FavoriteState {
  final List mediaList;

  const FavoriteSuccessState({
    required this.mediaList,
  });

  @override
  List<Object> get props => [mediaList];
}

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitialState());

  MediaRepository mediaRepository = MediaRepository();

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
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
        print(mediaList);

        yield FavoriteSuccessState(mediaList: mediaList);
      } catch (_) {
        yield FavoriteFailureState();
      }
    }
  }
}