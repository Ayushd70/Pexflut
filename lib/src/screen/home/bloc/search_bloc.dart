import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PhotoSearchEvent extends Equatable {
  PhotoSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchButton extends PhotoSearchEvent {
  SearchButton();
}

class BackArrow extends PhotoSearchEvent {
  BackArrow();
}

class Submit extends PhotoSearchEvent {
  final String keyWord;
  Submit({required this.keyWord});
}

abstract class PhotoSearchState extends Equatable {
  PhotoSearchState();

  @override
  List<Object> get props => [];
}

class InitialSearch extends PhotoSearchState {
  final String keyWord;
  InitialSearch({this.keyWord = ''});
  @override
  List<Object> get props => [keyWord];
}

class Typing extends PhotoSearchState {
  Typing();
}

class PhotoSearchBloc extends Bloc<PhotoSearchEvent, PhotoSearchState> {
  PhotoSearchBloc() : super(InitialSearch());
  @override
  Stream<PhotoSearchState> mapEventToState(PhotoSearchEvent event) async* {
    if (event is SearchButton) {
      yield Typing();
    }
    if (event is BackArrow) {
      yield InitialSearch();
    }
    if (event is Submit) {
      print("Submitted with keyWord = ${event.keyWord}");
    }
  }
}
