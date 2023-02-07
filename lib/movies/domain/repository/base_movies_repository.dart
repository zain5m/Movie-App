import 'package:dartz/dartz.dart';
import 'package:move/core/error/failure.dart';
import 'package:move/movies/domain/entities/movie.dart';
import 'package:move/movies/domain/entities/movie_detail.dart';
import 'package:move/movies/domain/entities/recommendation.dart';
import 'package:move/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:move/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:move/movies/domain/usecases/get_recommendation_usecase.dart';
import 'package:move/movies/domain/usecases/get_top_rated_movies_usecase.dart';

abstract class BaseMoviesRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  Future<Either<Failure, List<Movie>>> getPopularMovies(
      PopularMoviesParameters parameters);

  Future<Either<Failure, List<Movie>>> getTopRatedMoveis(
      TopRatedMoviesParameters parameters);

  Future<Either<Failure, MovieDetail>> getMovieDetails(
      MovieDetailsParameters parameters);

  Future<Either<Failure, List<Recommendation>>> getRecommendation(
      RecommendationParameters parameters);
}
