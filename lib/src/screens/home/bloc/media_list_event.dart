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

class LikeMediaEvent extends MediaListEvent {
  final int mediaTypeCode;
  final int mediaID;
  final int index;
  LikeMediaEvent({required this.mediaTypeCode, required this.mediaID, required this.index});
  @override
  List<Object> get props => [mediaTypeCode, mediaID, index];
}