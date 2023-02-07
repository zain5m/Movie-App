part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class BottomNavigationBarEvent extends AppEvent {
  final int nextIndex;
  const BottomNavigationBarEvent(this.nextIndex);

  @override
  List<Object> get props => [
        nextIndex,
      ];
}
