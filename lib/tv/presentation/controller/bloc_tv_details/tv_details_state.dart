part of 'tv_details_bloc.dart';

class TvDetailsState extends Equatable {
  final String? drop;
  final TvDetails? details;
  final RequestState detailsState;
  final String detailsMessage;
//
  final List<TvRecommendation> recommendation;
  final RequestState recommendationState;
  final String recommendationMessage;
  //
  final List<TvEpisodes> episodes;
  final RequestState episodesState;
  final String episodesMessage;
  const TvDetailsState({
    this.drop,
    this.details,
    this.detailsState = RequestState.loading,
    this.detailsMessage = '',
    this.recommendation = const [],
    this.recommendationState = RequestState.loading,
    this.recommendationMessage = '',
    this.episodes = const [],
    this.episodesMessage = '',
    this.episodesState = RequestState.loading,
  });
  TvDetailsState copyWith({
    String? drop,
    TvDetails? details,
    RequestState? detailsState,
    String? detailsMessage,
    List<TvRecommendation>? recommendation,
    RequestState? recommendationState,
    String? recommendationMessage,
    List<TvEpisodes>? episodes,
    RequestState? episodesState,
    String? episodesMessage,
  }) {
    return TvDetailsState(
      details: details ?? this.details,
      detailsMessage: detailsMessage ?? this.detailsMessage,
      detailsState: detailsState ?? this.detailsState,
      recommendation: recommendation ?? this.recommendation,
      recommendationState: recommendationState ?? this.recommendationState,
      recommendationMessage:
          recommendationMessage ?? this.recommendationMessage,
      episodes: episodes ?? this.episodes,
      episodesMessage: episodesMessage ?? this.episodesMessage,
      episodesState: episodesState ?? this.episodesState,
      drop: drop ?? this.drop,
    );
  }

  @override
  List<Object?> get props => [
        details,
        detailsState,
        detailsMessage,
        recommendation,
        recommendationMessage,
        recommendationState,
        episodes,
        episodesMessage,
        episodesState,
        drop,
      ];
}
