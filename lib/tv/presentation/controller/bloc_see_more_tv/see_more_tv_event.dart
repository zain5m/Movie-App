part of 'see_more_tv_bloc.dart';

abstract class SeeMoreTvEvent extends Equatable {
  const SeeMoreTvEvent();

  @override
  List<Object> get props => [];
}

class SeeMoreTvPopular extends SeeMoreTvEvent {}

class SeeMoreTvTopRated extends SeeMoreTvEvent {}
