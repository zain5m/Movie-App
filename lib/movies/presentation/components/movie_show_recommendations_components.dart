import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/network/api_constance.dart';
import 'package:move/core/utils/global/components.dart';
import 'package:move/core/utils/size_config.dart';
import 'package:move/movies/presentation/controller/bloc_movies_details/movie_details_bloc.dart';
import 'package:shimmer/shimmer.dart';

Widget showRecommendations() {
  return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
    builder: (context, state) {
      return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final recommendation = state.recommendation[index];
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
                                height: getProportionateScreenHeight(170),
                                width: getProportionateScreenWidth(120),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            height: getProportionateScreenHeight(180),
                            fit: BoxFit.cover,
                          )
                        : nullImage(
                            height: getProportionateScreenHeight(180),
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
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: getProportionateScreenHeight(8.0),
          crossAxisSpacing: getProportionateScreenWidth(8),
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
