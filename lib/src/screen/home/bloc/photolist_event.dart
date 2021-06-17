import 'package:equatable/equatable.dart';
import 'package:pex_flut/src/data/repository/media_repository.dart';
import 'package:pex_flut/src/models/image.dart';
import 'package:pex_flut/src/models/video.dart';


abstract class PhotoListEvent extends Equatable {
  final MediaType status;
  final int page;
  final String keyWord;
  PhotoListEvent({required this.status, required this.page, this.keyWord = ''});
}

class StatusChanged extends PhotoListEvent {
  StatusChanged({required MediaType status, required int page, required String keyWord})
      : super(status: status, page: page, keyWord: keyWord);

  @override
  List<Object> get props => [status, page, keyWord];
}

class ChooseImage extends PhotoListEvent {
  final Photo image;
  ChooseImage({required this.image});

  @override
  List<Object> get props => [image];
}

class ChooseVideo extends PhotoListEvent {
  final Video video;
  ChooseVideo({required this.video});

  @override
  List<Object> get props => [video];
}

class FetchData extends PhotoListEvent {
  FetchData({required MediaType mediaType, required int page, required String keyWord})
      : super(status: mediaType, page: page, keyWord: keyWord);

  @override
  List<Object> get props => [status, page, keyWord];
}

