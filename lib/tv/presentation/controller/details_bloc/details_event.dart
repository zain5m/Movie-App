part of 'details_bloc.dart';

abstract class TvDetailsEvent extends Equatable {
  const TvDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetTvDetailsEvent extends TvDetailsEvent {
  final int tvId;

  const GetTvDetailsEvent(this.tvId);
  @override
  List<Object> get props => [tvId];
}

class GetTvRecommendationEvent extends TvDetailsEvent {
  final int recommendationId;

  const GetTvRecommendationEvent(this.recommendationId);
  @override
  List<Object> get props => [
        recommendationId,
      ];
}

class GetTvEpisodesEvent extends TvDetailsEvent {
  final int episodesId;
  final int seasonNumber;

  const GetTvEpisodesEvent(
    this.episodesId,
    this.seasonNumber,
  );
  @override
  List<Object> get props => [
        episodesId,
        seasonNumber,
      ];
}

class ChangeDropEvent extends TvDetailsEvent {
  final String dropItem;

  const ChangeDropEvent(
    this.dropItem,
  );
  @override
  List<Object> get props => [
        dropItem,
      ];
}
