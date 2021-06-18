import 'package:equatable/equatable.dart';

class ImageSrc extends Equatable {
  ImageSrc(
      {this.original,
        this.large,
        this.large2x,
        this.medium,
        this.small,
        this.portrait,
        this.landscape,
        this.tiny});
  final String original;
  final String large;
  final String large2x;
  final String medium;
  final String small;
  final String portrait;
  final String landscape;
  final String tiny;

  factory ImageSrc.fromMap(Map<String, dynamic> map) => ImageSrc(
      original: map['original'],
      large: map['large'],
      large2x: map['large2x'],
      medium: map['medium'],
      small: map['small'],
      portrait: map['portrait'],
      landscape: map['landscape'],
      tiny: map['tiny']);

  @override
  List<Object> get props =>
      [original, large, large2x, medium, small, portrait, landscape, tiny];

  @override
  String toString() => '''
    original: $original,
    large: $large,
    large2x: $large2x,
    medium: $medium,
    small: $small,
    portrait: $portrait,
    landscape: $landscape,
    tiny: $tiny
  ''';
}