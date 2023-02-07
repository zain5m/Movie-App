import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move/core/services/services_locator.dart';
import 'package:move/movies/presentation/components/movie_detail_content_components.dart';
import 'package:move/movies/presentation/controller/bloc_movies_details/movie_details_bloc.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;

  const MovieDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieDetailsBloc>()
        ..add(GetMovieDetailsEvent(id))
        ..add(GetMovieRecommendationsEvent(id)),
      child: const Scaffold(
        body: MovieDetailContent(),
      ),
    );
  }
}
