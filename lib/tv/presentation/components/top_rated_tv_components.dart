import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/network/api_constance.dart';
import 'package:move/core/utils/enums.dart';
import 'package:move/core/utils/global/components.dart';
import 'package:move/core/utils/size_config.dart';
import 'package:move/tv/presentation/controller/bloc_tv/tv_bloc.dart';
import 'package:move/tv/presentation/screen/tv_details_screen.dart';
import 'package:shimmer/shimmer.dart';

class TopRatedTvComponents extends StatelessWidget {
  const TopRatedTvComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<TvBloc, TvState>(
      buildWhen: (previous, current) =>
          previous.topRtedState != current.topRtedState,
      builder: (context, state) {
        switch (state.topRtedState) {
          case RequestState.loading:
            return SizedBox(
              height: getProportionateScreenHeight(170),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case RequestState.loaded:
            return FadeIn(
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                height: getProportionateScreenHeight(170),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(16)),
                  itemCount: state.topRtedTv.length,
                  itemBuilder: (context, index) {
                    final movie = state.topRtedTv[index];
                    return Container(
                      padding: EdgeInsets.only(
                          right: getProportionateScreenWidth(8)),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TvDetailScreen(
                                id: movie.id,
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          child: movie.backdropPath != null
                              ? CachedNetworkImage(
                                  width: getProportionateScreenWidth(120),
                                  fit: BoxFit.cover,
                                  imageUrl: ApiConstance.imageUrl(
                                      movie.backdropPath!),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[850]!,
                                    highlightColor: Colors.grey[800]!,
                                    child: Container(
                                      height: getProportionateScreenHeight(170),
                                      width: getProportionateScreenWidth(120),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )
                              : nullImage(
                                  height: getProportionateScreenHeight(170),
                                  width: getProportionateScreenWidth(120),
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          case RequestState.error:
            return SizedBox(
              height: getProportionateScreenHeight(170),
              child: Center(
                child: Text(state.onTheAirmessage),
              ),
            );
        }
      },
    );
  }
}
