import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:move/core/services/services_locator.dart';
import 'package:move/core/utils/size_config.dart';
import 'package:move/tv/presentation/controller/bloc_see_more_tv/see_more_tv_bloc.dart';

class SeeMoreTvScreen extends StatelessWidget {
  final String textAppBar;
  final SeeMoreTvEvent event;
  final Widget screen;
  const SeeMoreTvScreen({
    Key? key,
    required this.event,
    required this.textAppBar,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor!.withOpacity(0.6),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        centerTitle: true,
        title: Text(
          "$textAppBar Tv",
          style: GoogleFonts.poppins(
            fontSize: SizeConfig.screentext * 19,
            fontWeight: FontWeight.w500,
            letterSpacing: SizeConfig.screentext * 0.15,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => sl<SeeMoreTvBloc>()..add(event),
        child: screen,
      ),
    );
  }
}
