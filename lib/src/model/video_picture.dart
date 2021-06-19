import 'package:equatable/equatable.dart';

class VideoPicture extends Equatable {
  VideoPicture({
    required this.id,
    this.picture,
    required this.nr,
  });

  final int id;
  final String? picture;
  final int nr;

  factory VideoPicture.fromMap(Map<String, dynamic> map) =>
      VideoPicture(id: map['id'], picture: map['picture'], nr: map['nr']);

  @override
  List<Object> get props => [id, nr];

  @override
  String toString() => '''
  id: $id,
  picture: $picture,
  nr: $nr
  ''';
}
