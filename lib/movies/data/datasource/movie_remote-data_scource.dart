import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:move/core/error/exceptions.dart';
import 'package:move/core/network/api_constance.dart';
import 'package:move/core/network/error_message_model.dart';
import 'package:move/movies/data/models/movie_details_model.dart';
import 'package:move/movies/data/models/movie_model.dart';
import 'package:move/movies/data/models/recommendation_model.dart';
import 'package:move/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:move/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:move/movies/domain/usecases/get_recommendation_usecase.dart';
import 'package:move/movies/domain/usecases/get_top_rated_movies_usecase.dart';

abstract class BaseMovieRemoteDataSource {
  Future<List<MovieModue>> getNowPlayingMovies();
  Future<List<MovieModue>> getPopularMovies(PopularMoviesParameters parameters);

  Future<List<MovieModue>> getTopRatedMovies(
      TopRatedMoviesParameters parameters);
  Future<MovieDetailModel> getMovieDetails(MovieDetailsParameters parameters);
  Future<List<RecommendationModel>> getRecommendation(
      RecommendationParameters parameters);
}

class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
  @override
  Future<List<MovieModue>> getNowPlayingMovies() async {
    final response = await Dio().get(ApiConstance.nowPlayingMoviesPath);
    if (response.statusCode == 200) {
      return List<MovieModue>.from(
        (response.data["results"] as List).map(
          (e) => MovieModue.fromJson(e),
        ),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieModue>> getPopularMovies(
      PopularMoviesParameters parameters) async {
    // try {
    final response = await Dio(
      BaseOptions(
        validateStatus: (statusCode) {
          if (statusCode == null) {
            return false;
          }
          if (statusCode == 422) {
            // your http status code
            return true;
          } else {
            return statusCode >= 200 && statusCode < 300;
          }
        },
      ),
    ).get(ApiConstance.popularMoviesPath(page: parameters.page));
    if (response.statusCode == 422) {
      return <MovieModue>[];
    } else if (response.statusCode == 200) {
      return List<MovieModue>.from(
        (response.data["results"] as List).map(
          (e) => MovieModue.fromJson(e),
        ),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
    // } catch (e) {
    //   final response = await Dio().get(ApiConstance.popularMoviesPath(page: 1));
    //   if (response.statusCode == 200) {
    //     return List<MovieModue>.from(
    //       (response.data["results"] as List).map(
    //         (e) => MovieModue.fromJson(e),
    //       ),
    //     );
    //   } else {
    //     throw ServerException(
    //       errorMessageModel: ErrorMessageModel.fromJson(response.data),
    //     );
    //   }
    // }
  }

  @override
  Future<List<MovieModue>> getTopRatedMovies(
      TopRatedMoviesParameters parameters) async {
    final response = await Dio(
      BaseOptions(
        validateStatus: (statusCode) {
          if (statusCode == null) {
            return false;
          }
          if (statusCode == 422) {
            // your http status code
            return true;
          } else {
            return statusCode >= 200 && statusCode < 300;
          }
        },
      ),
    ).get(ApiConstance.topRatedPath(page: parameters.page));
    if (response.statusCode == 422) {
      return <MovieModue>[];
    } else if (response.statusCode == 200) {
      return List<MovieModue>.from(
        (response.data["results"] as List).map(
          (e) => MovieModue.fromJson(e),
        ),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MovieDetailModel> getMovieDetails(
      MovieDetailsParameters parameters) async {
    final response =
        await Dio().get(ApiConstance.movieDetailsPath(parameters.movieId));
    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<RecommendationModel>> getRecommendation(
      RecommendationParameters parameters) async {
    final response =
        await Dio().get(ApiConstance.movieRecommendationPath(parameters.id));
    if (response.statusCode == 200) {
      return List<RecommendationModel>.from(
        (response.data["results"] as List).map(
          (e) => RecommendationModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
