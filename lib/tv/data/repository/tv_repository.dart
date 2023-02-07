import 'package:move/core/error/exceptions.dart';
import 'package:move/tv/data/datasource/tv_remote_data_source.dart';
import 'package:move/tv/domain/entities/tv.dart';
import 'package:move/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:move/tv/domain/entities/tv_details.dart';
import 'package:move/tv/domain/entities/tv_episodes.dart';
import 'package:move/tv/domain/entities/tv_recommendation.dart';
import 'package:move/tv/domain/repository/base_tv_repository.dart';
import 'package:move/tv/domain/usecases/get_episodes_tv_usecase.dart';
import 'package:move/tv/domain/usecases/get_recommendation_tv_usecase.dart';
import 'package:move/tv/domain/usecases/get_tv_details_usecase.dart';

class TvRebository extends BaseTvRepository {
  final BaseTvRemoteDataSource _baseTvRemoteDataSource;
  TvRebository(this._baseTvRemoteDataSource);
  @override
  Future<Either<Failure, List<Tv>>> getOnTheAirTv() async {
    final result = await _baseTvRemoteDataSource.getOnTheAirTv();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularTv() async {
    final result = await _baseTvRemoteDataSource.getPopularTv();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTv() async {
    final result = await _baseTvRemoteDataSource.getTopRatedTv();
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, TvDetails>> getTvDetails(
      TvDetailsParameters parameters) async {
    final result = await _baseTvRemoteDataSource.getDetailsTv(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<TvRecommendation>>> getRecommendationTv(
      TvRecommendationParameters parameters) async {
    final result =
        await _baseTvRemoteDataSource.getRecommendationTv(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<TvEpisodes>>> getEpisodesTv(
      TvEpisodesParameters parameters) async {
    final result = await _baseTvRemoteDataSource.getEpisodesTv(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
