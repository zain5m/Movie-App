part of 'see_more_movies_bloc.dart';

abstract class SeeMoreMoviesEvent extends Equatable {
  const SeeMoreMoviesEvent();

  @override
  List<Object> get props => [];
}

class SeeMoreMoviesPopular extends SeeMoreMoviesEvent {}

class SeeMoreMoviesTopRated extends SeeMoreMoviesEvent {}
