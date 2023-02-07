import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/movies/domain/entities/movie_detail.dart';
import 'package:move/movies/presentation/screen/movies_screen.dart';
import 'package:move/tv/presentation/screen/main_tv_screen.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState()) {
    on<BottomNavigationBarEvent>(_changeCurrentIndex);
  }

  FutureOr<void> _changeCurrentIndex(
      BottomNavigationBarEvent event, Emitter<AppState> emit) {
    emit(
      state.copyWith(
        currentIndex: event.nextIndex,
      ),
    );
  }
}
