import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/utils/enums.dart';
import 'package:move/movies/presentation/components/shared/bottom_loader%20_components.dart';
import 'package:move/tv/presentation/components/movies_list_item_tv.dart';
import 'package:move/tv/presentation/controller/bloc_see_more_tv/see_more_tv_bloc.dart';

class SeeMoreTopRatedTvComponents extends StatefulWidget {
  const SeeMoreTopRatedTvComponents({
    Key? key,
  }) : super(key: key);
  @override
  State<SeeMoreTopRatedTvComponents> createState() =>
      SeeMoreTopRatedComponentsState();
}

class SeeMoreTopRatedComponentsState
    extends State<SeeMoreTopRatedTvComponents> {
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
    if (_isBottom) context.read<SeeMoreTvBloc>().add(SeeMoreTvTopRated());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeeMoreTvBloc, SeeMoreTvState>(
      buildWhen: (previous, current) =>
          previous.topRatedsTv != current.topRatedsTv,
      builder: (context, state) {
        switch (state.statusTopRatedTv) {
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestState.loaded:
            if (state.topRatedsTv.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.topRatedsTv.length
                    ? const BottomLoader()
                    : FadeIn(
                        duration: const Duration(milliseconds: 500),
                        child: MoviesListItemTv(
                          movie: state.topRatedsTv[index],
                        ),
                      );
              },
              itemCount: state.hasReachedMax
                  ? state.topRatedsTv.length
                  : state.topRatedsTv.length + 1,
              controller: _scrollController,
            );
          case RequestState.error:
            return const Center(child: Text('failed to fetch Movies'));
        }
      },
    );
  }
}
