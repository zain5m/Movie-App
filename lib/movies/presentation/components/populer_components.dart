import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/network/api_constance.dart';
import 'package:move/core/utils/enums.dart';
import 'package:move/core/utils/global/components.dart';
import 'package:move/core/utils/size_config.dart';
import 'package:move/movies/domain/entities/movie.dart';
import 'package:move/movies/presentation/controller/bloc_movies/movies_bloc.dart';
import 'package:move/movies/presentation/controller/bloc_movies/movies_state.dart';
import 'package:move/movies/presentation/screen/movie_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class PopulerComponents extends StatelessWidget {
  const PopulerComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<MoviesBloc, MoviesState>(
      buildWhen: (previous, current) =>
          previous.populerState != current.populerState,
      builder: (context, state) {
        switch (state.populerState) {
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
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: state.populerMovies!.length,
                  itemBuilder: (context, index) {
                    final movie = state.populerMovies![index];
                    return PopulerItem(movie: movie);
                  },
                ),
              ),
            );

          case RequestState.error:
            return SizedBox(
              height: 170,
              child: Center(child: Text(state.populermessage)),
            );
        }
      },
    );
  }
}

class PopulerItem extends StatelessWidget {
  const PopulerItem({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: getProportionateScreenWidth(8.0)),
      child: InkWell(
        onTap: () {
          navigatorTo(
            context,
            MovieDetailScreen(
              id: movie.id,
            ),
          );
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          child: movie.backdropPath != null
              ? CachedNetworkImage(
                  width: getProportionateScreenWidth(120.0),
                  fit: BoxFit.cover,
                  imageUrl: ApiConstance.imageUrl(movie.backdropPath!),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[850]!,
                    highlightColor: Colors.grey[800]!,
                    child: Container(
                      height: getProportionateScreenHeight(170.0),
                      width: getProportionateScreenWidth(120.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : nullImage(
                  width: getProportionateScreenWidth(120.0),
                ),
        ),
      ),
    );
  }
}
