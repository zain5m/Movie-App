part of 'app_bloc.dart';

class AppState extends Equatable {
  final int currentIndex;
  final List<Widget> screens = [
    const MainMoviesScreen(),
    const MainTvScreen(),
  ];
  AppState({
    this.currentIndex = 0,
  });
  AppState copyWith({
    int? currentIndex,
  }) {
    return AppState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object> get props => [
        currentIndex,
      ];
}
