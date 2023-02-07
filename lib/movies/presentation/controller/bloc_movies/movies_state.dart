import 'package:equatable/equatable.dart';

import 'package:move/core/utils/enums.dart';
import 'package:move/movies/domain/entities/movie.dart';

class MoviesState extends Equatable {
  final List<Movie> nowPlayingMovies;
  final RequestState nowPlayingState;
  final String nowPlayingmessage;

  //

  List<Movie>? populerMovies = [];
  final RequestState populerState;
  final String populermessage;
  //
  final List<Movie> topRtedMovies;
  final RequestState topRtedState;
  final String topRtedmessage;

  MoviesState({
    this.nowPlayingMovies = const [],
    this.nowPlayingState = RequestState.loading,
    this.nowPlayingmessage = '',
    //

    this.populerMovies = const [],
    this.populerState = RequestState.loading,
    this.populermessage = '',
    //
    this.topRtedMovies = const [],
    this.topRtedState = RequestState.loading,
    this.topRtedmessage = '',
  });
  MoviesState copyWith({
    List<Movie>? nowPlayingMovies,
    RequestState? nowPlayingState,
    String? nowPlayingmessage,
    //
    int? page,
    List<Movie>? populerMovies,
    RequestState? populerState,
    String? populermessage,
    //
    List<Movie>? topRtedMovies,
    RequestState? topRtedState,
    String? topRtedmessage,
  }) {
    return MoviesState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      nowPlayingmessage: nowPlayingmessage ?? this.nowPlayingmessage,
      //

      populerMovies: populerMovies ?? this.populerMovies,
      populerState: populerState ?? this.populerState,
      populermessage: populermessage ?? this.populermessage,
      //

      topRtedMovies: topRtedMovies ?? this.topRtedMovies,
      topRtedState: topRtedState ?? this.topRtedState,
      topRtedmessage: topRtedmessage ?? this.topRtedmessage,
    );
  }

  @override
  List<Object?> get props => [
        nowPlayingMovies,
        nowPlayingState,
        nowPlayingmessage,
        //

        populerMovies,
        populerState,
        populermessage,
        //
        topRtedMovies,
        topRtedState,
        topRtedmessage,
      ];
}
