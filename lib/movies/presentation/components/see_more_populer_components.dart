import 'package:animate_do/animate_do.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/utils/enums.dart';
import 'package:move/movies/presentation/components/shared/bottom_loader%20_components.dart';
import 'package:move/movies/presentation/components/shared/movies_list_item.dart';
import 'package:move/movies/presentation/controller/bloc_see_more/see_more_bloc.dart';
import 'package:move/movies/presentation/screen/see_more_screen.dart';

class SeeMorePopulerComponents extends StatefulWidget {
  const SeeMorePopulerComponents({Key? key}) : super(key: key);
  @override
  State<SeeMorePopulerComponents> createState() => SeeMorPopuleScreenState();
}

class SeeMorPopuleScreenState extends State<SeeMorePopulerComponents> {
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
    if (_isBottom) context.read<SeeMoreBloc>().add(SeeMorePopular());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeeMoreBloc, SeeMoreState>(
      buildWhen: (previous, current) => previous.populars != current.populars,
      builder: (context, state) {
        switch (state.statusPopular) {
          case RequestState.loading:
            return const Center(child: CircularProgressIndicator());
          case RequestState.loaded:
            if (state.populars.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.populars.length
                    ? const BottomLoader()
                    : FadeIn(
                        duration: const Duration(milliseconds: 500),
                        child: MoviesListItem(
                          movie: state.populars[index],
                        ),
                      );
              },
              itemCount: state.hasReachedMax
                  ? state.populars.length
                  : state.populars.length + 1,
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
