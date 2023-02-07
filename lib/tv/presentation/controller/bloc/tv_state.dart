part of 'tv_bloc.dart';

class TvState extends Equatable {
  final List<Tv> onTheAirTv;
  final RequestState onTheAirState;
  final String onTheAirmessage;
  //
  final List<Tv> populerTv;
  final RequestState populerState;
  final String populermessage;
  //
  final List<Tv> topRtedTv;
  final RequestState topRtedState;
  final String topRtedmessage;
  const TvState({
    this.onTheAirTv = const [],
    this.onTheAirState = RequestState.loading,
    this.onTheAirmessage = '',
    //
    this.populerTv = const [],
    this.populerState = RequestState.loading,
    this.populermessage = '',
    //
    this.topRtedTv = const [],
    this.topRtedState = RequestState.loading,
    this.topRtedmessage = '',
  });
  TvState copyWith({
    List<Tv>? onTheAirTv,
    RequestState? onTheAirState,
    String? onTheAirmessage,
    //
    List<Tv>? populerTv,
    RequestState? populerState,
    String? populermessage,
    //
    List<Tv>? topRtedTv,
    RequestState? topRtedState,
    String? topRtedmessage,
  }) {
    return TvState(
      onTheAirTv: onTheAirTv ?? this.onTheAirTv,
      onTheAirState: onTheAirState ?? this.onTheAirState,
      onTheAirmessage: onTheAirmessage ?? this.onTheAirmessage,
      //
      topRtedTv: topRtedTv ?? this.topRtedTv,
      topRtedState: topRtedState ?? this.topRtedState,
      topRtedmessage: topRtedmessage ?? this.topRtedmessage,
      //
      populerTv: populerTv ?? this.populerTv,
      populerState: populerState ?? this.populerState,
      populermessage: populermessage ?? this.populermessage,
    );
  }

  @override
  List<Object> get props => [
        onTheAirTv,
        onTheAirState,
        onTheAirmessage,
        //
        populerTv,
        populerState,
        populermessage,
        //
        topRtedTv,
        topRtedState,
        topRtedmessage,
      ];
}
