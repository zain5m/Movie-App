import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:move/core/error/failure.dart';
import 'package:move/tv/domain/entities/tv.dart';
import 'package:move/tv/domain/entities/tv_details.dart';
import 'package:move/tv/domain/entities/tv_episodes.dart';
import 'package:move/tv/domain/entities/tv_recommendation.dart';
import 'package:move/tv/domain/usecases/get_episodes_tv_usecase.dart';
import 'package:move/tv/domain/usecases/get_recommendation_tv_usecase.dart';
import 'package:move/tv/domain/usecases/get_tv_details_usecase.dart';

abstract class BaseTvRepository {
  Future<Either<Failure, List<Tv>>> getOnTheAirTv();

  Future<Either<Failure, List<Tv>>> getPopularTv();

  Future<Either<Failure, List<Tv>>> getTopRatedTv();

  Future<Either<Failure, TvDetails>> getTvDetails(
      TvDetailsParameters parameters);

  Future<Either<Failure, List<TvRecommendation>>> getRecommendationTv(
      TvRecommendationParameters parameters);
  Future<Either<Failure, List<TvEpisodes>>> getEpisodesTv(
      TvEpisodesParameters parameters);
}
