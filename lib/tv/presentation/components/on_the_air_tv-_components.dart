import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/network/api_constance.dart';
import 'package:move/core/utils/enums.dart';
import 'package:move/core/utils/global/components.dart';
import 'package:move/core/utils/size_config.dart';
import 'package:move/tv/presentation/controller/bloc_tv/tv_bloc.dart';
import 'package:move/tv/presentation/screen/tv_details_screen.dart';

class OnTheAirTvComponents extends StatelessWidget {
  const OnTheAirTvComponents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<TvBloc, TvState>(
      buildWhen: (previous, current) =>
          previous.onTheAirState != current.onTheAirState,
      builder: (context, state) {
        switch (state.onTheAirState) {
          case RequestState.loading:
            return SizedBox(
              height: getProportionateScreenHeight(400),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );

          case RequestState.loaded:
            return FadeIn(
              duration: Duration(milliseconds: 500),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: getProportionateScreenHeight(400),
                  viewportFraction: 1.0,
                  autoPlay: true,
                ),
                items: state.onTheAirTv.map(
                  (item) {
                    return GestureDetector(
                      key: Key('openTvMinimalDetail'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TvDetailScreen(id: item.id),
                            ));
                      },
                      child: Stack(
                        children: [
                          ShaderMask(
                            shaderCallback: (rect) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  // fromLTRB
                                  Colors.transparent,
                                  Colors.black,
                                  Colors.black,
                                  Colors.transparent,
                                ],
                                stops: [0, 0.3, 0.5, 1],
                              ).createShader(
                                Rect.fromLTRB(
                                  0,
                                  0,
                                  rect.width,
                                  rect.height,
                                ),
                              );
                            },
                            blendMode: BlendMode.dstIn,
                            child: item.backdropPath != null
                                ? CachedNetworkImage(
                                    height: getProportionateScreenHeight(560),
                                    imageUrl: ApiConstance.imageUrl(
                                        item.backdropPath!),
                                    fit: BoxFit.cover,
                                  )
                                : nullImage(
                                    height: getProportionateScreenHeight(560),
                                  ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                          getProportionateScreenHeight(16.0)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.circle,
                                        color: Colors.red,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(4),
                                      ),
                                      Text(
                                        "ON THE AIR".toUpperCase(),
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.screentext * 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Text(
                                    item.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: SizeConfig.screentext * 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ),
            );

          case RequestState.error:
            return Center(
              child: Text(state.onTheAirmessage),
            );
        }
      },
    );
  }
}
