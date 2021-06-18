import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PhotoSearchEvent extends Equatable {
  PhotoSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchButtonEvent extends PhotoSearchEvent {
  SearchButtonEvent();
}

class BackArrowEvent extends PhotoSearchEvent {
  BackArrowEvent();
}

class SubmitEvent extends PhotoSearchEvent {
  final String keyWord;
  SubmitEvent({required this.keyWord});
  @override
  List<Object> get props => [keyWord];
}

abstract class PhotoSearchState extends Equatable {
  PhotoSearchState();

  @override
  List<Object> get props => [];
}

class InitialSearchState extends PhotoSearchState {
  InitialSearchState();
}

class TypingState extends PhotoSearchState {
  final String keyWord;
  TypingState({required this.keyWord});
  @override
  List<Object> get props => [keyWord];
}

class SearchedState extends PhotoSearchState {
  final String keyWord;
  SearchedState({required this.keyWord});
  @override
  List<Object> get props => [keyWord];
}

class PhotoSearchBloc extends Bloc<PhotoSearchEvent, PhotoSearchState> {
  String keyWord = '';
  PhotoSearchBloc() : super(InitialSearchState());
  @override
  Stream<PhotoSearchState> mapEventToState(PhotoSearchEvent event) async* {
    if (event is SearchButtonEvent) {
      yield TypingState(keyWord: '');
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