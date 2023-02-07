part of 'see_more_bloc.dart';

abstract class SeeMoreEvent extends Equatable {
  const SeeMoreEvent();

  @override
  List<Object> get props => [];
}

class SeeMorePopular extends SeeMoreEvent {}

class SeeMoreTopRated extends SeeMoreEvent {}
