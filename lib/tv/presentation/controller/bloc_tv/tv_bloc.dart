import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:move/core/usecases/base_usecase.dart';
import 'package:move/core/utils/enums.dart';
import 'package:move/tv/domain/entities/tv.dart';
import 'package:move/tv/domain/usecases/get_on_the_air_tv.dart';
import 'package:move/tv/domain/usecases/get_popular_tv.dart';
import 'package:move/tv/domain/usecases/get_top_rated_tv.dart';

part 'tv_event.dart';
part 'tv_state.dart';

class TvBloc extends Bloc<TvEvent, TvState> {
  final GetOnTheAirTvUsecase _getOnTheAirTvUsecase;
  final GetPopulerTvUsecase _getPopulerTvUsecase;
  final GetTopRatedTvUsecase _getTopRatedTvUsecase;
  TvBloc(
    this._getOnTheAirTvUsecase,
    this._getPopulerTvUsecase,
    this._getTopRatedTvUsecase,
  ) : super(const TvState()) {
    on<GetOnTheAirTvEvent>(_getOnTheAirTv);
    on<GetPopularTvEvent>(_getPopularTv);
    on<GetTopRatedTvEvent>(_getTopRatedTv);
  }
  FutureOr<void> _getOnTheAirTv(
      GetOnTheAirTvEvent event, Emitter<TvState> emit) async {
    final result = await _getOnTheAirTvUsecase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
          onTheAirState: RequestState.error,
          onTheAirmessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          onTheAirState: RequestState.loaded,
          onTheAirTv: r,
        ),
      ),
    );
  }

  FutureOr<void> _getPopularTv(
      GetPopularTvEvent event, Emitter<TvState> emit) async {
    final result = await _getPopulerTvUsecase(
      const PopularTvParameters(
        page: 1,
      ),
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          populerState: RequestState.error,
          populermessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          populerState: RequestState.loaded,
          populerTv: r,
        ),
      ),
    );
  }

  FutureOr<void> _getTopRatedTv(
      GetTopRatedTvEvent event, Emitter<TvState> emit) async {
    final result = await _getTopRatedTvUsecase(const TopRatedTvParameters(
      page: 1,
    ));
    result.fold(
      (l) => emit(
        state.copyWith(
          topRtedState: RequestState.error,
          topRtedmessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          topRtedState: RequestState.loaded,
          topRtedTv: r,
        ),
      ),
    );
  }
}
