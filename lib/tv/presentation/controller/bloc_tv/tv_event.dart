part of 'tv_bloc.dart';

abstract class TvEvent extends Equatable {
  const TvEvent();

  @override
  List<Object> get props => [];
}

class GetOnTheAirTvEvent extends TvEvent {}

class GetPopularTvEvent extends TvEvent {}

class GetTopRatedTvEvent extends TvEvent {}
