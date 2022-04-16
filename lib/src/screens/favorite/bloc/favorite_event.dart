abstract class FavoriteEvent {}

class FavoriteFetchEvent extends FavoriteEvent {}

class DislikeEvent extends FavoriteEvent {
  final int mediaTypeCode;
  final int mediaID;
  DislikeEvent({
    required this.mediaTypeCode,
    required this.mediaID,
  });
}
