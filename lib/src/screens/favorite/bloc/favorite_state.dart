import 'package:equatable/equatable.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitialState extends FavoriteState {}

class FavoriteFailureState extends FavoriteState {}

class FavoriteSuccessState extends FavoriteState {
  final List mediaList;

  const FavoriteSuccessState({
    required this.mediaList,
  });

  @override
  List<Object> get props => [mediaList];
}
