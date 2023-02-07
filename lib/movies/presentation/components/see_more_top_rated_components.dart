import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/utils/enums.dart';
import 'package:move/movies/presentation/components/shared/bottom_loader%20_components.dart';
import 'package:move/movies/presentation/components/shared/movies_list_item.dart';
import 'package:move/movies/presentation/controller/bloc_see_more_movies/see_more_movies_bloc.dart';

class SeeMoreTopRatedComponents extends StatefulWidget {
  const SeeMoreTopRatedComponents({
    Key? key,
  }) : super(key: key);
  @override
  State<SeeMoreTopRatedComponents> createState() =>
      SeeMoreTopRatedComponentsState();
}

class SeeMoreTopRatedComponentsState extends State<SeeMoreTopRatedComponents> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom)
      context.read<SeeMoreMoviesBloc>().add(SeeMoreMoviesTopRated());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeeMoreMoviesBloc, SeeMoreMoviesState>(
      buildWhen: (previous, current) => previous.topRateds != current.topRateds,
      builder: (context, state) {
        switch (state.statusTopRated) {
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestState.loaded:
            if (state.topRateds.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.topRateds.length
                    ? const BottomLoader()
                    : FadeIn(
                        duration: const Duration(milliseconds: 500),
                        child: MoviesListItem(
                          movie: state.topRateds[index],
                        ),
                      );
              },
              itemCount: state.hasReachedMax
                  ? state.topRateds.length
                  : state.topRateds.length + 1,
              controller: _scrollController,
            );
          case RequestState.error:
            return const Center(child: Text('failed to fetch Movies'));
        }
      },
    );
  }
}
