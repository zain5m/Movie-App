import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/usecases/base_usecase.dart';
import 'package:move/core/utils/enums.dart';
import 'package:move/movies/domain/entities/movie.dart';
import 'package:move/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:move/movies/domain/usecases/get_popular_movies_usecase.dart';

import 'package:move/movies/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:move/movies/presentation/controller/bloc_movies/movies_event.dart';
import 'package:move/movies/presentation/controller/bloc_movies/movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;

  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  MoviesBloc(
    this.getNowPlayingMoviesUseCase,
    this.getPopularMoviesUseCase,
    this.getTopRatedMoviesUseCase,
  ) : super(MoviesState()) {
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);
    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
    on<GetPopularMoviesEvent>(_getPopulerMovies);
  }
  List<Movie> move = [];
  RequestState moveState = RequestState.loading;

  FutureOr<void> _getNowPlayingMovies(
      GetNowPlayingMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getNowPlayingMoviesUseCase(const NoParameters());

    result.fold(
      (l) => emit(
        state.copyWith(
          nowPlayingState: RequestState.error,
          nowPlayingmessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          nowPlayingMovies: r,
          nowPlayingState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getTopRatedMovies(
      GetTopRatedMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getTopRatedMoviesUseCase(
      const TopRatedMoviesParameters(
        page: 1,
      ),
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          topRtedState: RequestState.error,
          topRtedmessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(
          topRtedMovies: r,
          topRtedState: RequestState.loaded,
        ),
      ),
    );
  }

  FutureOr<void> _getPopulerMovies(
      GetPopularMoviesEvent event, Emitter<MoviesState> emit) async {
    final result = await getPopularMoviesUseCase(
      const PopularMoviesParameters(
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
      (r) {
        emit(
          state.copyWith(
            populerMovies: r,
            populerState: RequestState.loaded,
          ),
        );
      },
    );
  }
}
