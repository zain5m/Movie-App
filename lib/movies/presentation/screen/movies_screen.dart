import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:move/core/services/services_locator.dart';
import 'package:move/core/utils/app_string.dart';
import 'package:move/core/utils/size_config.dart';
import 'package:move/movies/presentation/components/shared/botton_see_more.dart';
import 'package:move/movies/presentation/components/now_playing_components.dart';
import 'package:move/movies/presentation/components/populer_components.dart';
import 'package:move/movies/presentation/components/see_more_populer_components.dart';
import 'package:move/movies/presentation/components/see_more_top_rated_components.dart';
import 'package:move/movies/presentation/components/top_rated_components.dart';
import 'package:move/movies/presentation/controller/bloc_movies/movies_bloc.dart';
import 'package:move/movies/presentation/controller/bloc_movies/movies_event.dart';
import 'package:move/movies/presentation/controller/bloc_see_more/see_more_bloc.dart';
import 'package:move/movies/presentation/screen/see_more_screen.dart';

class MainMoviesScreen extends StatelessWidget {
  const MainMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => sl<MoviesBloc>()
        ..add(GetNowPlayingMoviesEvent())
        ..add(GetPopularMoviesEvent())
        ..add(GetTopRatedMoviesEvent()),
      child: Scaffold(
        body: SingleChildScrollView(
          key: const Key('movieScrollView'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NowPlayingComponest(),
              BottomSeeMore(
                text: AppString.popular,
                nextPage: SeeMoreScreen(
                  event: SeeMorePopular(),
                  screen: const SeeMorePopulerComponents(),
                  textAppBar: AppString.popular,
                ),
              ),
              PopulerComponents(),
              BottomSeeMore(
                text: AppString.topRated,
                nextPage: SeeMoreScreen(
                  event: SeeMoreTopRated(),
                  screen: const SeeMoreTopRatedComponents(),
                  textAppBar: AppString.topRated,
                ),
              ),
              const TopRatedComponents(),
              SizedBox(height: getProportionateScreenHeight(50)),
            ],
          ),
        ),
      ),
    );
  }
}
