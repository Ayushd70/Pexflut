abstract class MediaDetailEvent {
  MediaDetailEvent();
}

class InitialMediaDetailEvent extends MediaDetailEvent {
  final String mediaType;
  final String mediaKey;
  InitialMediaDetailEvent({required this.mediaType, required this.mediaKey});
}

class LikedEvent extends MediaDetailEvent {
  final int mediaTypeCode;
  final int mediaID;
  LikedEvent({required this.mediaTypeCode, required this.mediaID});
}