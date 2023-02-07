import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:move/core/network/api_constance.dart';
import 'package:move/core/services/services_locator.dart';
import 'package:move/core/utils/app_string.dart';
import 'package:move/core/utils/global/components.dart';
import 'package:move/core/utils/size_config.dart';
import 'package:move/movies/domain/entities/movie.dart';
import 'package:move/movies/presentation/controller/bloc_see_more/see_more_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/utils/enums.dart';

class SeeMoreScreen extends StatelessWidget {
  final String textAppBar;
  final SeeMoreEvent event;
  final Widget screen;
  const SeeMoreScreen({
    Key? key,
    required this.event,
    required this.textAppBar,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          "$textAppBar Movies",
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => sl<SeeMoreBloc>()..add(event),
        child: screen,
      ),
    );
  }
}
