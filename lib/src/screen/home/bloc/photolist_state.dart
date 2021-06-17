import 'package:equatable/equatable.dart';
import 'package:pex_flut/src/models/image.dart';
import 'package:pex_flut/src/models/video.dart';


abstract class PhotoListState extends Equatable {
  final String status;
  PhotoListState({required this.status});

  @override
  List<Object> get props => [];
}

class InitialList extends PhotoListState {
  final String status;
  InitialList({required this.status}) : super(status: status);
}

class ShowList extends PhotoListState {
  final List<Photo> photos;
  final List<Video> videos;
  ShowList({required this.photos, required this.videos, required String status}) : super(status: status);
}

class Fetching extends PhotoListState {
  Fetching(String status) : super(status: status);
}

class FetchingFail extends PhotoListState {
  FetchingFail(String status) : super(status: status);
}