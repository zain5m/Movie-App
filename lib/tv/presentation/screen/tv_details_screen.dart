import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:move/core/network/api_constance.dart';
import 'package:move/core/services/services_locator.dart';
import 'package:move/core/utils/app_string.dart';
import 'package:move/core/utils/enums.dart';
import 'package:move/core/utils/global/components.dart';
import 'package:move/core/utils/size_config.dart';
import 'package:move/movies/domain/entities/genres.dart';

import 'package:move/tv/domain/entities/seasons.dart';
import 'package:move/tv/domain/entities/tv_episodes.dart';
import 'package:move/tv/presentation/controller/bloc_tv_details/tv_details_bloc.dart';
import 'package:shimmer/shimmer.dart';

class TvDetailScreen extends StatelessWidget {
  final int id;

  const TvDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TvDetailsBloc>()
        ..add(GetTvDetailsEvent(id))
        ..add(GetTvRecommendationEvent(id)),
      child: const Scaffold(
        body: MovieDetailContent(),
      ),
    );
  }
}

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<TvDetailsBloc, TvDetailsState>(
      buildWhen: (previous, current) =>
          previous.detailsState != current.detailsState,
      builder: (context, state) {
        switch (state.detailsState) {
          case RequestState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case RequestState.loaded:
            return DefaultTabController(
              length: 2,
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: getProportionateScreenHeight(250),
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
                                Rect.fromLTRB(
                                    0.0, 0.0, rect.width, rect.height),
                              );
                            },
                            blendMode: BlendMode.dstIn,
                            child: state.details!.backdropPath != null
                                ? CachedNetworkImage(
                                    width: SizeConfig.screenWidth,
                                    imageUrl: ApiConstance.imageUrl(
                                        state.details!.backdropPath!),
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
                              EdgeInsets.all(getProportionateScreenHeight(16)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.details!.name,
                                style: GoogleFonts.poppins(
                                  fontSize: SizeConfig.screentext * 23,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: SizeConfig.screentext * 1.2,
                                ),
                              ),
                              SizedBox(height: getProportionateScreenHeight(8)),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: getProportionateScreenHeight(2),
                                      horizontal:
                                          getProportionateScreenWidth(8),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      state.details!.firstAirDate.split('-')[0],
                                      style: TextStyle(
                                        fontSize: SizeConfig.screentext * 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(16)),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20.0,
                                      ),
                                      SizedBox(
                                          width:
                                              getProportionateScreenWidth(4)),
                                      Text(
                                        (state.details!.voteAverage / 2)
                                            .toStringAsFixed(1),
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.screentext * 16.0,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing:
                                              SizeConfig.screentext * 1.2,
                                        ),
                                      ),
                                      SizedBox(
                                          width:
                                              getProportionateScreenWidth(4)),
                                    ],
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(16)),
                                  state.details!.episodeRunTime.isNotEmpty
                                      ? Text(
                                          _showDuration(
                                              state.details!.episodeRunTime[0]),
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize:
                                                SizeConfig.screentext * 16.0,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.2,
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(20)),
                              Text(
                                state.details!.overview,
                                style: TextStyle(
                                  fontSize: SizeConfig.screentext * 14.0,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: SizeConfig.screentext * 1.2,
                                ),
                              ),
                              SizedBox(height: getProportionateScreenHeight(8)),
                              Text(
                                '${AppString.genres}: ${_showGenres(state.details!.genres)}',
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
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          onTap: (value) {
                            if (value == 0) {
                              // context.read<TvDetailsBloc>().add(
                              //       GetTvEpisodesEvent(
                              //         state.details!.id,
                              //         state.details!.numberOfSeasons,
                              //       ),
                              // );
                            }
                          },
                          // controller: _tabController,
                          indicator: UnderlineTabIndicator(
                            insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 45.0),
                            borderSide: BorderSide(
                              color: Color(0XFFFF5252),
                              width: getProportionateScreenWidth(2),
                            ),
                          ),
                          tabs: [
                            Tab(
                              child: Text(
                                AppString.episodes.toUpperCase(),
                                style: TextStyle(
                                  letterSpacing: SizeConfig.screentext * 1.2,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                AppString.moreLikeThis.toUpperCase(),
                                style: TextStyle(
                                  letterSpacing: SizeConfig.screentext * 1.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    // Scaffold(),
                    _showEpisodes(
                      context: context,
                      id: state.details!.id,
                      index: state.details!.numberOfSeasons,
                    ),
                    _showRecommendations(),
                  ],
                ),
              ),
            );
          case RequestState.error:
            return Center(
              child: Text(state.detailsMessage),
            );
        }
      },
    );
  }

  String _showGenres(List<Genres> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }
    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Widget _showEpisodes(
      {required int id, required int index, required BuildContext context}) {
    BlocProvider.of<TvDetailsBloc>(context).add(
      GetTvEpisodesEvent(
        id,
        index,
      ),
    );
    return BlocBuilder<TvDetailsBloc, TvDetailsState>(
      buildWhen: (previous, current) =>
          previous.episodesState != current.episodesState,
      builder: (context, state) {
        switch (state.episodesState) {
          case RequestState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case RequestState.loaded:
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15),
                    vertical: getProportionateScreenHeight(8)),
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: getProportionateScreenHeight(15)),
                      child: SizedBox(
                        height: getProportionateScreenHeight(50),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            fillColor: Color(0xFF303030),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          dropdownColor: Color(0xFF303030),
                          items: List.generate(
                            state.details!.seasons.length,
                            (index) {
                              return DropdownMenuItem(
                                value: state.details!.seasons[index].name,
                                child: Text(
                                  state.details!.seasons[index].name,
                                  style: TextStyle(
                                    letterSpacing: SizeConfig.screentext * 1.4,
                                  ),
                                ),
                              );
                            },
                          ),
                          value: state.drop,
                          onChanged: (item) {
                            int index1 = state.details!.seasons.indexWhere(
                              (element) => element.name == item,
                            );
                            context.read<TvDetailsBloc>().add(
                                  GetTvEpisodesEvent(
                                    state.details!.id,
                                    state.details!.seasons[index1].seasonNumber,
                                  ),
                                );
                          },
                        ),
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: getProportionateScreenHeight(15)),
                      itemBuilder: (context, index) {
                        final episodes = state.episodes[index];
                        String formattedDate = DateFormat('MMM dd,yyyy')
                            .format(DateTime.parse(episodes.airDate));
                        return Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: FadeInUp(
                                    from: 20,
                                    duration: const Duration(milliseconds: 500),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: episodes.stillPath != null
                                          ? CachedNetworkImage(
                                              width:
                                                  getProportionateScreenWidth(
                                                      150),
                                              height:
                                                  getProportionateScreenHeight(
                                                      90),
                                              imageUrl: ApiConstance.imageUrl(
                                                  episodes.stillPath!),
                                              placeholder: (context, url) =>
                                                  Shimmer.fromColors(
                                                baseColor: Colors.grey[850]!,
                                                highlightColor:
                                                    Colors.grey[800]!,
                                                child: Container(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          10),
                                                  width:
                                                      getProportionateScreenWidth(
                                                          10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                              fit: BoxFit.cover,
                                            )
                                          : nullImage(
                                              height:
                                                  getProportionateScreenHeight(
                                                      10),
                                              width:
                                                  getProportionateScreenWidth(
                                                      10),
                                            ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        episodes.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              getProportionateScreenHeight(5)),
                                      Text(
                                        formattedDate,
                                        style: TextStyle(
                                          letterSpacing:
                                              SizeConfig.screentext * 1.2,
                                          color: Colors.white70,
                                          fontSize:
                                              SizeConfig.screentext * 12.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: getProportionateScreenHeight(10)),
                            Text(
                              episodes.overview,
                              style: TextStyle(
                                letterSpacing: SizeConfig.screentext * 1.2,
                                color: Colors.white70,
                                fontSize: SizeConfig.screentext * 12.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: state.episodes.length,
                    ),
                  ],
                ),
              ),
            );
          case RequestState.error:
            return Center(
              child: Text(state.detailsMessage),
            );
        }
      },
    );
  }

  Widget _showRecommendations() {
    return BlocBuilder<TvDetailsBloc, TvDetailsState>(
      // bloc: TvDetailsBloc(
      //   sl(),
      //   sl(),
      //   sl(),
      // )..add(event),
      buildWhen: (previous, current) =>
          previous.recommendationState != current.recommendationState,
      builder: (context, state) {
        switch (state.recommendationState) {
          case RequestState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case RequestState.loaded:
            return Scaffold(
              body: GridView.builder(
                itemBuilder: (context, index) {
                  final recommendation = state.recommendation[index];
                  return FadeInUp(
                    from: 20,
                    duration: const Duration(milliseconds: 500),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          recommendation.backdropPath != null
                              ? CachedNetworkImage(
                                  imageUrl: ApiConstance.imageUrl(
                                      recommendation.backdropPath!),
                                  // ApiConstance.imageUrl('/qMLUqH9pEw95gFwrichBAIuKigh.jpg'),
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
                                  height: getProportionateScreenHeight(180),
                                  fit: BoxFit.cover,
                                )
                              : nullImage(
                                  height: getProportionateScreenHeight(180),
                                  width: getProportionateScreenWidth(120),
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
                itemCount: state.recommendation.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: getProportionateScreenHeight(8),
                  crossAxisSpacing: getProportionateScreenWidth(8),
                  childAspectRatio: 0.7,
                  crossAxisCount: 3,
                ),
              ),
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
