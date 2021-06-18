abstract class FavoriteEvent {}

class FavoriteFetchEvent extends FavoriteEvent {}

class DislikeEvent extends FavoriteEvent {
  final int mediaTypeCode;
  final int mediaID;
  DislikeEvent({this.mediaTypeCode, this.mediaID});
}