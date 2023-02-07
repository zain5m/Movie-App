import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/utils/enums.dart';
import 'package:move/core/utils/size_config.dart';
import 'package:move/movies/presentation/components/populer_components.dart';
import 'package:move/movies/presentation/controller/bloc_movies/movies_bloc.dart';
import 'package:move/movies/presentation/controller/bloc_movies/movies_state.dart';

class TopRatedComponents extends StatelessWidget {
  const TopRatedComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<MoviesBloc, MoviesState>(
      buildWhen: (previous, current) =>
          previous.topRtedState != current.topRtedState,
      builder: (context, state) {
        switch (state.topRtedState) {
          case RequestState.loading:
            return SizedBox(
              height: getProportionateScreenHeight(170.0),
              child: const Center(child: CircularProgressIndicator()),
            );
          case RequestState.loaded:
            return FadeIn(
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                height: getProportionateScreenHeight(170.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(16.0)),
                  itemCount: state.topRtedMovies.length,
                  itemBuilder: (context, index) {
                    final movie = state.topRtedMovies[index];
                    return PopulerItem(movie: movie);
                  },
                ),
              ),
            );
          case RequestState.error:
            return SizedBox(
              height: getProportionateScreenHeight(170),
              child: Center(child: Text(state.topRtedmessage)),
            );
        }
      },
    );
  }
}
