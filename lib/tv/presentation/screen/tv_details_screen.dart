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
import 'package:move/movies/domain/entities/genres.dart';

import 'package:move/tv/domain/entities/seasons.dart';
import 'package:move/tv/domain/entities/tv_episodes.dart';
import 'package:move/tv/presentation/controller/details_bloc/details_bloc.dart';
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
                      expandedHeight: 250.0,
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
                                    width: MediaQuery.of(context).size.width,
                                    imageUrl: ApiConstance.imageUrl(
                                        state.details!.backdropPath!),
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/images/not_found.png',
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
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
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.details!.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2.0,
                                      horizontal: 8.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      state.details!.firstAirDate.split('-')[0],
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20.0,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        (state.details!.voteAverage / 2)
                                            .toStringAsFixed(1),
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                      const SizedBox(width: 4.0),
                                    ],
                                  ),
                                  const SizedBox(width: 16.0),
                                  state.details!.episodeRunTime.isNotEmpty
                                      ? Text(
                                          _showDuration(
                                              state.details!.episodeRunTime[0]),
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.2,
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Text(
                                state.details!.overview,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                '${AppString.genres}: ${_showGenres(state.details!.genres)}',
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
                              width: 2,
                            ),
                          ),
                          tabs: [
                            Tab(
                              child: Text(
                                AppString.episodes.toUpperCase(),
                                style: TextStyle(
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                AppString.moreLikeThis.toUpperCase(),
                                style: TextStyle(
                                  letterSpacing: 1.2,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        height: 50,
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
                                  style: const TextStyle(
                                    letterSpacing: 1.4,
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
                          SizedBox(height: 15),
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
                                              width: 150,
                                              height: 90.0,
                                              imageUrl: ApiConstance.imageUrl(
                                                  episodes.stillPath!),
                                              placeholder: (context, url) =>
                                                  Shimmer.fromColors(
                                                baseColor: Colors.grey[850]!,
                                                highlightColor:
                                                    Colors.grey[800]!,
                                                child: Container(
                                                  height: 10.0,
                                                  width: 10.0,
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
                                          : Image.asset(
                                              'assets/images/not_found.png',
                                              width: 150,
                                              height: 90.0,
                                              fit: BoxFit.cover,
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
                                      SizedBox(height: 5),
                                      Text(
                                        formattedDate,
                                        style: TextStyle(
                                          letterSpacing: 1.2,
                                          color: Colors.white70,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              episodes.overview,
                              style: TextStyle(
                                letterSpacing: 1.2,
                                color: Colors.white70,
                                fontSize: 12.0,
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
                                      height: 170.0,
                                      width: 120.0,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  height: 180.0,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/not_found.png',
                                  height: 180.0,
                                  fit: BoxFit.cover,
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
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
