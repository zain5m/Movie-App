import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/utils/enums.dart';
import 'package:move/movies/presentation/components/shared/bottom_loader%20_components.dart';
import 'package:move/tv/domain/entities/tv.dart';
import 'package:move/tv/presentation/components/movies_list_item_tv.dart';
import 'package:move/tv/presentation/controller/bloc_see_more_tv/see_more_tv_bloc.dart';

class SeeMorePopulerTvComponents extends StatefulWidget {
  const SeeMorePopulerTvComponents({Key? key}) : super(key: key);
  @override
  State<SeeMorePopulerTvComponents> createState() => SeeMorPopuleScreenState();
}

class SeeMorPopuleScreenState extends State<SeeMorePopulerTvComponents> {
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
    if (_isBottom) context.read<SeeMoreTvBloc>().add(SeeMoreTvPopular());
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
          previous.popularsTv != current.popularsTv,
      builder: (context, state) {
        switch (state.statusPopularTv) {
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestState.loaded:
            if (state.popularsTv.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.popularsTv.length
                    ? const BottomLoader()
                    : FadeIn(
                        duration: const Duration(milliseconds: 500),
                        child: MoviesListItemTv(
                          movie: state.popularsTv[index],
                        ),
                      );
              },
              itemCount: state.hasReachedMax
                  ? state.popularsTv.length
                  : state.popularsTv.length + 1,
              controller: _scrollController,
            );
          case RequestState.error:
            return const Center(child: Text('failed to fetch Movie'));
        }
      },
    );
    // );
  }
}
