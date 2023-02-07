import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/utils/enums.dart';
import 'package:move/tv/domain/entities/tv_details.dart';
import 'package:move/tv/domain/entities/tv_episodes.dart';
import 'package:move/tv/domain/entities/tv_recommendation.dart';
import 'package:move/tv/domain/usecases/get_episodes_tv_usecase.dart';
import 'package:move/tv/domain/usecases/get_recommendation_tv_usecase.dart';
import 'package:move/tv/domain/usecases/get_tv_details_usecase.dart';

part 'tv_details_event.dart';
part 'tv_details_state.dart';

class TvDetailsBloc extends Bloc<TvDetailsEvent, TvDetailsState> {
  final GetTvDetailsUseCase _getTvDetailsUseCase;
  final GetRecommendationTvUseCase _getRecommendationTvUseCase;
  final GetEpisodesTvUseCase _episodesTvUseCase;

  TvDetailsBloc(
    this._getTvDetailsUseCase,
    this._getRecommendationTvUseCase,
    this._episodesTvUseCase,
  ) : super(const TvDetailsState()) {
    on<GetTvDetailsEvent>(_getTvDetails);
    on<GetTvRecommendationEvent>(_getTvRecommendation);
    on<GetTvEpisodesEvent>(_getTvEpisodes);
    // on<ChangeDropEvent>(_changeDrop);
  }

  FutureOr<void> _getTvDetails(
      GetTvDetailsEvent event, Emitter<TvDetailsState> emit) async {
    final result =
        await _getTvDetailsUseCase(TvDetailsParameters(tvId: event.tvId));

    result.fold(
      (l) => emit(
        state.copyWith(
          detailsState: RequestState.error,
          detailsMessage: l.message,
        ),
      ),
      (r) {
        int index = r.seasons.indexWhere(
          (element) => element.seasonNumber == r.numberOfSeasons,
        );

        emit(
          state.copyWith(
            drop: r.seasons[index].name,
            details: r,
            detailsState: RequestState.loaded,
          ),
        );
      },
    );
  }

  FutureOr<void> _getTvRecommendation(
      GetTvRecommendationEvent event, Emitter<TvDetailsState> emit) async {
    final result = await _getRecommendationTvUseCase(
        TvRecommendationParameters(tvRecommendationId: event.recommendationId));
    result.fold(
      (l) => emit(
        state.copyWith(
          recommendationState: RequestState.error,
          recommendationMessage: l.message,
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            recommendationState: RequestState.loaded,
            recommendation: r,
          ),
        );
      },
    );
  }

  FutureOr<void> _getTvEpisodes(
      GetTvEpisodesEvent event, Emitter<TvDetailsState> emit) async {
    emit(
      state.copyWith(episodesState: RequestState.loading),
    );
    final result = await _episodesTvUseCase(TvEpisodesParameters(
      seasonNumber: event.seasonNumber,
      tvEpisodesId: event.episodesId,
    ));

    result.fold(
      (l) => emit(
        state.copyWith(
          episodesState: RequestState.error,
          episodesMessage: l.message,
        ),
      ),
      (r) {
        int index = state.details!.seasons.indexWhere(
          (element) => element.seasonNumber == event.seasonNumber,
        );

        emit(
          state.copyWith(
            drop: state.details!.seasons[index].name,
            episodesState: RequestState.loaded,
            episodes: r,
          ),
        );
      },
    );
  }

  // FutureOr<void> _changeDrop(
  //     ChangeDropEvent event, Emitter<TvDetailsState> emit) {
  //   // print(event.dropItem);
  //   emit(
  //     state.copyWith(drop: event.dropItem),
  //   );
  // }
}
