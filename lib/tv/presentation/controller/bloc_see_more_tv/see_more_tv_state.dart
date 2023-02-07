part of 'see_more_tv_bloc.dart';

class SeeMoreTvState extends Equatable {
  final RequestState statusPopularTv;
  final String messagePopularTv;
  final List<Tv> popularsTv;
  //
  final RequestState statusTopRatedTv;
  final String messageTopRatedTv;
  final List<Tv> topRatedsTv;
  //
  final bool hasReachedMax;
  final int page;

  const SeeMoreTvState({
    this.statusPopularTv = RequestState.loading,
    this.messagePopularTv = "",
    this.popularsTv = const <Tv>[],
    //
    this.statusTopRatedTv = RequestState.loading,
    this.messageTopRatedTv = "",
    this.topRatedsTv = const <Tv>[],
    //
    this.hasReachedMax = false,
    this.page = 1,
  });
  SeeMoreTvState copyWith({
    RequestState? statusPopularTv,
    List<Tv>? popularsTv,
    String? messagePopularTv,
    //
    RequestState? statusTopRatedTv,
    String? messageTopRatedTv,
    List<Tv>? topRatedsTv,
    //
    bool? hasReachedMax,
    int? page,
  }) {
    return SeeMoreTvState(
      statusPopularTv: statusPopularTv ?? this.statusPopularTv,
      popularsTv: popularsTv ?? this.popularsTv,
      messagePopularTv: messagePopularTv ?? this.messagePopularTv,
      //
      statusTopRatedTv: statusTopRatedTv ?? this.statusTopRatedTv,
      topRatedsTv: topRatedsTv ?? this.topRatedsTv,
      messageTopRatedTv: messageTopRatedTv ?? this.messageTopRatedTv,
      //
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,

      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [
        statusPopularTv,
        messagePopularTv,
        popularsTv,
        statusTopRatedTv,
        topRatedsTv,
        messageTopRatedTv,
        hasReachedMax,
        page,
      ];
}
