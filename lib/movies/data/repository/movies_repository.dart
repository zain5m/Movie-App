import 'package:dartz/dartz.dart';
import 'package:move/core/error/exceptions.dart';
import 'package:move/core/error/failure.dart';
import 'package:move/movies/data/datasource/movie_remote-data_scource.dart';
import 'package:move/movies/domain/entities/movie.dart';
import 'package:move/movies/domain/entities/movie_detail.dart';
import 'package:move/movies/domain/entities/recommendation.dart';
import 'package:move/movies/domain/repository/base_movies_repository.dart';
import 'package:move/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:move/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:move/movies/domain/usecases/get_recommendation_usecase.dart';
import 'package:move/movies/domain/usecases/get_top_rated_movies_usecase.dart';

class MoviesRepository extends BaseMoviesRepository {
  final BaseMovieRemoteDataSource baseMovieRemoteDataSource;

  MoviesRepository(this.baseMovieRemoteDataSource);
  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    final result = await baseMovieRemoteDataSource.getNowPlayingMovies();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies(
      PopularMoviesParameters parameters) async {
    final result = await baseMovieRemoteDataSource.getPopularMovies(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMoveis(
      TopRatedMoviesParameters parameters) async {
    final result =
        await baseMovieRemoteDataSource.getTopRatedMovies(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetails(
      MovieDetailsParameters parameters) async {
    final result = await baseMovieRemoteDataSource.getMovieDetails(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Recommendation>>> getRecommendation(
      RecommendationParameters parameters) async {
    final result =
        await baseMovieRemoteDataSource.getRecommendation(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
