import 'package:equatable/equatable.dart';

class VideoUser extends Equatable {
  VideoUser({required this.id, required this.name, required this.url});
  final int id;
  final String name;
  final String url;

  factory VideoUser.fromMap(Map<String, dynamic> map) =>
      VideoUser(id: map['id'], name: map['name'], url: map['url']);

  @override
  List<Object> get props => [id, name, url];

  @override
  String toString() => '''
  id: $id,
  name: $name,
  url: $url,
  ''';
}