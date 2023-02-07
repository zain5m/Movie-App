import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:move/core/services/services_locator.dart';
import 'package:move/core/utils/app_string.dart';
import 'package:move/core/utils/size_config.dart';
import 'package:move/movies/presentation/components/see_more_populer_components.dart';
import 'package:move/movies/presentation/components/see_more_top_rated_components.dart';
import 'package:move/movies/presentation/components/shared/botton_see_more.dart';
import 'package:move/tv/presentation/components/on_the_air_tv-_components.dart';
import 'package:move/tv/presentation/components/populer_tv_components.dart';
import 'package:move/tv/presentation/components/see_more_populer_tv_components.dart';
import 'package:move/tv/presentation/components/see_more_top_rated_tv_components.dart';
import 'package:move/tv/presentation/components/top_rated_tv_components.dart';
import 'package:move/tv/presentation/controller/bloc_see_more_tv/see_more_tv_bloc.dart';
import 'package:move/tv/presentation/controller/bloc_tv/tv_bloc.dart';
import 'package:move/tv/presentation/screen/see_more_tv_screen.dart';

class MainTvScreen extends StatelessWidget {
  const MainTvScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => sl<TvBloc>()
        ..add(GetOnTheAirTvEvent())
        ..add(GetPopularTvEvent())
        ..add(GetTopRatedTvEvent()),
      child: Scaffold(
        body: SingleChildScrollView(
          key: const Key("TvScreollView"),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const OnTheAirTvComponents(),
              BottomSeeMore(
                text: AppString.popular,
                nextPage: SeeMoreTvScreen(
                  event: SeeMoreTvPopular(),
                  screen: const SeeMorePopulerTvComponents(),
                  textAppBar: AppString.popular,
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         AppString.popular,
              //         style: GoogleFonts.poppins(
              //           fontSize: SizeConfig.screentext * 19,
              //           fontWeight: FontWeight.w500,
              //           letterSpacing: SizeConfig.screentext * 0.15,
              //           color: Colors.white,
              //         ),
              //       ),
              //       InkWell(
              //         onTap: () {
              //           // Todo : NAVIGATION TO POPULAR SCREEN
              //         },
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Row(
              //             children: const [
              //               Text(
              //                 AppString.seeMore,
              //                 style: TextStyle(color: Colors.white),
              //               ),
              //               Icon(
              //                 Icons.arrow_forward_ios,
              //                 size: 16.0,
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const PopulerTvComponents(),
              BottomSeeMore(
                text: AppString.topRated,
                nextPage: SeeMoreTvScreen(
                  event: SeeMoreTvTopRated(),
                  screen: const SeeMoreTopRatedTvComponents(),
                  textAppBar: AppString.topRated,
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.fromLTRB(
              //     16.0,
              //     24.0,
              //     16.0,
              //     8.0,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         AppString.topRated,
              //         style: GoogleFonts.poppins(
              //           color: Colors.white,
              //           fontSize: 19,
              //           fontWeight: FontWeight.w500,
              //           letterSpacing: 0.15,
              //         ),
              //       ),
              //       InkWell(
              //         onTap: () {
              //           /// TODO : NAVIGATION TO Top Rated Movies Screen
              //         },
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Row(
              //             children: const [
              //               Text(
              //                 AppString.seeMore,
              //                 style: TextStyle(color: Colors.white),
              //               ),
              //               Icon(
              //                 Icons.arrow_forward_ios,
              //                 size: 16.0,
              //                 color: Colors.white,
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const TopRatedTvComponents(),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
