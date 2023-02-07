import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/utils/enums.dart';
import 'package:move/tv/domain/entities/tv.dart';
import 'package:move/tv/domain/usecases/get_popular_tv.dart';
import 'package:move/tv/domain/usecases/get_top_rated_tv.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
part 'see_more_tv_event.dart';
part 'see_more_tv_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class SeeMoreTvBloc extends Bloc<SeeMoreTvEvent, SeeMoreTvState> {
  final GetPopulerTvUsecase _getPopularTvUseCase;
  final GetTopRatedTvUsecase _getTopRatedTvUseCase;

  static SeeMoreTvBloc get(context) => BlocProvider.of(context);
  SeeMoreTvBloc(
    this._getPopularTvUseCase,
    this._getTopRatedTvUseCase,
  ) : super(const SeeMoreTvState()) {
    on<SeeMoreTvPopular>(
      _getPopularSeeMoreTv,
      transformer: throttleDroppable(throttleDuration),
    );
    on<SeeMoreTvTopRated>(
      _getTopRatedSeeMoreTv,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  FutureOr<void> _getPopularSeeMoreTv(
      SeeMoreTvPopular event, Emitter<SeeMoreTvState> emit) async {
    if (state.hasReachedMax) return;
    final result = await _getPopularTvUseCase(
      PopularTvParameters(
        page: state.page,
      ),
    );

    result.fold(
      (l) => emit(
        SeeMoreTvState(
          messagePopularTv: l.message,
          statusPopularTv: RequestState.error,
        ),
      ),
      (r) {
        emit(r.isEmpty
            ? state.copyWith(
                hasReachedMax: true,
                statusPopularTv: RequestState.loaded,
              )
            : state.copyWith(
                statusPopularTv: RequestState.loaded,
                popularsTv: List.of(state.popularsTv)..addAll(r),
                hasReachedMax: false,
                page: state.page + 1,
              ));
      },
    );
  }

  FutureOr<void> _getTopRatedSeeMoreTv(
      SeeMoreTvTopRated event, Emitter<SeeMoreTvState> emit) async {
    if (state.hasReachedMax) return;

    final result = await _getTopRatedTvUseCase(
      TopRatedTvParameters(
        page: state.page,
      ),
    );

    result.fold(
      (l) => emit(
        SeeMoreTvState(
          messageTopRatedTv: l.message,
          statusTopRatedTv: RequestState.error,
        ),
      ),
      (r) {
        emit(r.isEmpty
            ? state.copyWith(
                hasReachedMax: true,
                statusTopRatedTv: RequestState.loaded,
              )
            : state.copyWith(
                statusTopRatedTv: RequestState.loaded,
                topRatedsTv: List.of(state.topRatedsTv)..addAll(r),
                hasReachedMax: false,
                page: state.page + 1,
              ));
      },
    );
  }
}
