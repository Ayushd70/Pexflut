import 'package:equatable/equatable.dart';

abstract class MediaListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MediaListFetchedEvent extends MediaListEvent {}

class MediaListTypeChangeEvent extends MediaListEvent {
  final int mediaTypeCode;
  MediaListTypeChangeEvent({required this.mediaTypeCode});
}

class SearchMediaEvent extends MediaListEvent {
  final String keyWord;
  SearchMediaEvent({this.keyWord = ''});
  @override
  List<Object> get props => [];
}