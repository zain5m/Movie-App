import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:move/core/network/api_constance.dart';
import 'package:move/core/utils/app_constance.dart';
import 'package:move/core/utils/app_string.dart';
import 'package:move/core/utils/enums.dart';
import 'package:move/core/utils/global/components.dart';
import 'package:move/core/utils/size_config.dart';
import 'package:move/movies/presentation/controller/bloc_movies_details/movie_details_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'movie_show_recommendations_components.dart';

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        switch (state.movieDetailsState) {
          case RequestState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case RequestState.loaded:
            return CustomScrollView(
              key: const Key('movieDetailScrollView'),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: getProportionateScreenHeight(250.0),
                  flexibleSpace: FlexibleSpaceBar(
                    background: FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black,
                              Colors.black,
                              Colors.transparent,
                            ],
                            stops: [0.0, 0.5, 1.0, 1.0],
                          ).createShader(
                            Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                          );
                        },
                        blendMode: BlendMode.dstIn,
                        child: state.movieDetails!.backdropPath != null
                            ? CachedNetworkImage(
                                width: SizeConfig.screenWidth,
                                imageUrl: ApiConstance.imageUrl(
                                    state.movieDetails!.backdropPath!),
                                fit: BoxFit.cover,
                              )
                            : nullImage(
                                width: SizeConfig.screenWidth,
                              ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: FadeInUp(
                    from: 20,
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding:
                          EdgeInsets.all(getProportionateScreenHeight(16.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.movieDetails!.title,
                            style: GoogleFonts.poppins(
                              fontSize: SizeConfig.screentext * 23,
                              fontWeight: FontWeight.w700,
                              letterSpacing: SizeConfig.screentext * 1.2,
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(8.0)),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: getProportionateScreenHeight(2),
                                  horizontal: getProportionateScreenWidth(8),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[800],
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: Text(
                                  state.movieDetails!.releaseDate.split('-')[0],
                                  style: TextStyle(
                                    fontSize: SizeConfig.screentext * 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: getProportionateScreenWidth(16)),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20.0,
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(4)),
                                  Text(
                                    (state.movieDetails!.voteAverage / 2)
                                        .toStringAsFixed(1),
                                    style: TextStyle(
                                      fontSize: SizeConfig.screentext * 16.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing:
                                          SizeConfig.screentext * 1.2,
                                    ),
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(4)),
                                  Text(
                                    '(${state.movieDetails!.voteAverage})',
                                    style: TextStyle(
                                      fontSize: SizeConfig.screentext * 1.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing:
                                          SizeConfig.screentext * 1.2,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: getProportionateScreenWidth(16)),
                              Text(
                                AppConstance.showDuration(
                                    state.movieDetails!.runtime),
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: SizeConfig.screentext * 16.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: SizeConfig.screentext * 1.2,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          Text(
                            state.movieDetails!.overview,
                            style: TextStyle(
                              fontSize: SizeConfig.screentext * 14.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: SizeConfig.screentext * 1.2,
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(8)),
                          Text(
                            '${AppString.genres}: ${AppConstance.showGenres(state.movieDetails!.genres)}',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: SizeConfig.screentext * 12.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: SizeConfig.screentext * 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    getProportionateScreenWidth(16),
                    getProportionateScreenHeight(16),
                    getProportionateScreenWidth(16),
                    getProportionateScreenHeight(24),
                  ),
                  sliver: SliverToBoxAdapter(
                    child: FadeInUp(
                      from: 20,
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        AppString.moreLikeThis.toUpperCase(),
                        style: TextStyle(
                          fontSize: SizeConfig.screentext * 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: SizeConfig.screentext * 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
                // Tab(text: 'More like this'.toUpperCase()),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                    getProportionateScreenWidth(16),
                    getProportionateScreenHeight(0),
                    getProportionateScreenWidth(16),
                    getProportionateScreenHeight(24),
                  ),
                  sliver: showRecommendations(),
                ),
              ],
            );
          case RequestState.error:
            return Center(
              child: Text(state.recommendationMessage),
            );
        }
      },
    );
  }
}
