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
                              fontSize: 23,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
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
                                  style: const TextStyle(
                                    fontSize: 16.0,
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
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(4)),
                                  Text(
                                    '(${state.movieDetails!.voteAverage})',
                                    style: const TextStyle(
                                      fontSize: 1.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: getProportionateScreenWidth(16)),
                              Text(
                                AppConstance.showDuration(
                                    state.movieDetails!.runtime),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          Text(
                            state.movieDetails!.overview,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(8)),
                          Text(
                            '${AppString.genres}: ${AppConstance.showGenres(state.movieDetails!.genres)}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
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
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
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
                  sliver: _showRecommendations(),
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

  Widget _showRecommendations() {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      builder: (context, state) {
        return SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final recommendation = state.recommendation[index];
              print(recommendation.backdropPath);
              return FadeInUp(
                from: 20,
                duration: const Duration(milliseconds: 500),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      recommendation.backdropPath != null
                          ? CachedNetworkImage(
                              imageUrl: ApiConstance.imageUrl(
                                  recommendation.backdropPath!),
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[850]!,
                                highlightColor: Colors.grey[800]!,
                                child: Container(
                                  height: 170.0,
                                  width: 120.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              height: 180.0,
                              fit: BoxFit.cover,
                            )
                          : nullImage(
                              width: getProportionateScreenWidth(120.0),
                            ),
                      // Text(
                      //   recommendation.title,
                      //   style: TextStyle(
                      //     foreground: Paint()
                      //       ..blendMode = BlendMode.dstOut
                      //       ..style = PaintingStyle.stroke
                      //       ..color = Colors.white
                      //       ..strokeWidth = 2
                      //       ..strokeCap = StrokeCap.butt
                      //       ..strokeJoin = StrokeJoin.bevel,
                      //     fontSize: 20.0,
                      //     fontWeight: FontWeight.w600,
                      //     letterSpacing: 1.2,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            },
            childCount: state.recommendation.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 0.7,
            crossAxisCount: 3,
          ),
        );
        // case RequestState.error:
        //   return Center(
        //     child: Text(state.recommendationMessage),
        //   );
        // }
      },
    );
  }
}
