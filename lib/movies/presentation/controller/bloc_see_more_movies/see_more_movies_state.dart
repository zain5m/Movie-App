part of 'see_more_movies_bloc.dart';

class SeeMoreMoviesState extends Equatable {
  final RequestState statusPopular;
  final String messagePopular;
  final List<Movie> populars;
  //
  final RequestState statusTopRated;
  final String messageTopRated;
  final List<Movie> topRateds;
  //
  final bool hasReachedMax;
  final int page;

  const SeeMoreMoviesState({
    this.statusPopular = RequestState.loading,
    this.messagePopular = "",
    this.populars = const <Movie>[],
    //
    this.statusTopRated = RequestState.loading,
    this.messageTopRated = "",
    this.topRateds = const <Movie>[],
    //
    this.hasReachedMax = false,
    this.page = 1,
  });
  SeeMoreMoviesState copyWith({
    RequestState? statusPopular,
    List<Movie>? populars,
    String? messagePopular,
    //
    RequestState? statusTopRated,
    String? messageTopRated,
    List<Movie>? topRateds,
    //
    bool? hasReachedMax,
    int? page,
  }) {
    return SeeMoreMoviesState(
      statusPopular: statusPopular ?? this.statusPopular,
      populars: populars ?? this.populars,
      messagePopular: messagePopular ?? this.messagePopular,
      //
      statusTopRated: statusTopRated ?? this.statusTopRated,
      topRateds: topRateds ?? this.topRateds,
      messageTopRated: messageTopRated ?? this.messageTopRated,
      //
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,

      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [
        statusPopular,
        messagePopular,
        populars,
        statusTopRated,
        topRateds,
        messageTopRated,
        hasReachedMax,
        page,
      ];
}
