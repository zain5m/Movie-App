import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/utils/enums.dart';
import 'package:move/movies/domain/entities/movie.dart';
import 'package:move/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:move/movies/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'see_more_movies_event.dart';
part 'see_more_movies_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class SeeMoreMoviesBloc extends Bloc<SeeMoreMoviesEvent, SeeMoreMoviesState> {
  final GetPopularMoviesUseCase _getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase _getTopRatedMoviesUseCase;

  static SeeMoreMoviesBloc get(context) => BlocProvider.of(context);
  SeeMoreMoviesBloc(
    this._getPopularMoviesUseCase,
    this._getTopRatedMoviesUseCase,
  ) : super(const SeeMoreMoviesState()) {
    on<SeeMoreMoviesPopular>(
      _getPopularSeeMore,
      transformer: throttleDroppable(throttleDuration),
    );
    on<SeeMoreMoviesTopRated>(
      _getTopRatedSeeMore,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  FutureOr<void> _getPopularSeeMore(
      SeeMoreMoviesPopular event, Emitter<SeeMoreMoviesState> emit) async {
    if (state.hasReachedMax) return;
    final result = await _getPopularMoviesUseCase(
      PopularMoviesParameters(
        page: state.page,
      ),
    );

    result.fold(
      (l) => emit(
        SeeMoreMoviesState(
          messagePopular: l.message,
          statusPopular: RequestState.error,
        ),
      ),
      (r) {
        emit(r.isEmpty
            ? state.copyWith(
                hasReachedMax: true,
                statusPopular: RequestState.loaded,
              )
            : state.copyWith(
                statusPopular: RequestState.loaded,
                populars: List.of(state.populars)..addAll(r),
                hasReachedMax: false,
                page: state.page + 1,
              ));
      },
    );
  }

  FutureOr<void> _getTopRatedSeeMore(
      SeeMoreMoviesTopRated event, Emitter<SeeMoreMoviesState> emit) async {
    if (state.hasReachedMax) return;

    final result = await _getTopRatedMoviesUseCase(
      TopRatedMoviesParameters(
        page: state.page,
      ),
    );

    result.fold(
      (l) => emit(
        SeeMoreMoviesState(
          messageTopRated: l.message,
          statusTopRated: RequestState.error,
        ),
      ),
      (r) {
        emit(r.isEmpty
            ? state.copyWith(
                hasReachedMax: true,
                statusTopRated: RequestState.loaded,
              )
            : state.copyWith(
                statusTopRated: RequestState.loaded,
                topRateds: List.of(state.topRateds)..addAll(r),
                hasReachedMax: false,
                page: state.page + 1,
              ));
      },
    );
  }
}
