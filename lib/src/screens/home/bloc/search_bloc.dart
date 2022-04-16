import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class MediaSearchEvent extends Equatable {
  MediaSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchButtonEvent extends MediaSearchEvent {
  SearchButtonEvent();
}

class BackArrowEvent extends MediaSearchEvent {
  BackArrowEvent();
}

class SubmitEvent extends MediaSearchEvent {
  final String keyWord;
  SubmitEvent({required this.keyWord});
  @override
  List<Object> get props => [keyWord];
}

abstract class MediaSearchState extends Equatable {
  MediaSearchState();

  @override
  List<Object> get props => [];
}

class InitialSearchState extends MediaSearchState {
  InitialSearchState();
}

class TypingState extends MediaSearchState {
  final String keyWord;
  TypingState({required this.keyWord});
  @override
  List<Object> get props => [keyWord];
}

class SearchedState extends MediaSearchState {
  final String keyWord;
  SearchedState({required this.keyWord});
  @override
  List<Object> get props => [keyWord];
}

class MediaSearchBloc extends Bloc<MediaSearchEvent, MediaSearchState> {
  String keyWord = '';
  MediaSearchBloc() : super(InitialSearchState());
  @override
  Stream<MediaSearchState> mapEventToState(MediaSearchEvent event) async* {
    if (event is SearchButtonEvent) {
      yield TypingState(keyWord: keyWord);
    }
    if (event is BackArrowEvent) {
      yield InitialSearchState();
    }
    if (event is SubmitEvent) {
      keyWord = event.keyWord;
      yield SearchedState(keyWord: keyWord);
    }
  }
}
