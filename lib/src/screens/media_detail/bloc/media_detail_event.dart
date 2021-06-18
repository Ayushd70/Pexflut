abstract class MediaDetailEvent {
  MediaDetailEvent();
}

class InitialMediaDetailEvent extends MediaDetailEvent {
  final String mediaType;
  final String mediaKey;
  InitialMediaDetailEvent({this.mediaType, this.mediaKey});
}

class LikedEvent extends MediaDetailEvent {
  final int mediaTypeCode;
  final int mediaID;
  LikedEvent({this.mediaTypeCode, this.mediaID});
}