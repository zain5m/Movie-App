import 'package:dio/dio.dart';
import 'package:move/core/error/exceptions.dart';
import 'package:move/core/network/api_constance.dart';
import 'package:move/core/network/error_message_model.dart';
import 'package:move/tv/data/models/tv_details_model.dart';
import 'package:move/tv/data/models/tv_episodes_model.dart';
import 'package:move/tv/data/models/tv_model.dart';
import 'package:move/tv/data/models/tv_recommendation_model.dart';
import 'package:move/tv/domain/entities/tv.dart';
import 'package:move/tv/domain/entities/tv_details.dart';
import 'package:move/tv/domain/entities/tv_recommendation.dart';
import 'package:move/tv/domain/usecases/get_episodes_tv_usecase.dart';
import 'package:move/tv/domain/usecases/get_recommendation_tv_usecase.dart';
import 'package:move/tv/domain/usecases/get_tv_details_usecase.dart';

abstract class BaseTvRemoteDataSource {
  Future<List<TvModel>> getOnTheAirTv();

  Future<List<TvModel>> getPopularTv();

  Future<List<TvModel>> getTopRatedTv();
  Future<TvDetailsModel> getDetailsTv(TvDetailsParameters parameters);
  Future<List<TvRecommendationModel>> getRecommendationTv(
      TvRecommendationParameters parameters);
  Future<List<TvEpisodesModel>> getEpisodesTv(TvEpisodesParameters parameters);
}

class TvRemoteDataSource extends BaseTvRemoteDataSource {
  @override
  Future<List<TvModel>> getOnTheAirTv() async {
    final response = await Dio().get(ApiConstance.onTheAirPath);
    if (response.statusCode == 200) {
      return List<TvModel>.from(
        (response.data["results"] as List).map(
          (e) => TvModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TvModel>> getPopularTv() async {
    final response = await Dio().get(ApiConstance.popularTvPath);
    if (response.statusCode == 200) {
      return List<TvModel>.from(
        (response.data["results"] as List).map(
          (e) => TvModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TvModel>> getTopRatedTv() async {
    final response = await Dio().get(ApiConstance.topRatedTvPath);
    if (response.statusCode == 200) {
      return List<TvModel>.from(
        (response.data["results"] as List).map(
          (e) => TvModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<TvDetailsModel> getDetailsTv(TvDetailsParameters parameters) async {
    final response =
        await Dio().get(ApiConstance.tvDetailsPath(parameters.tvId));
    if (response.statusCode == 200) {
      return TvDetailsModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TvRecommendationModel>> getRecommendationTv(
      TvRecommendationParameters parameters) async {
    final response = await Dio()
        .get(ApiConstance.tvRecommendationPath(parameters.tvRecommendationId));
    if (response.statusCode == 200) {
      return List<TvRecommendationModel>.from(
        (response.data["results"] as List).map(
          (e) => TvRecommendationModel.fromJson(e),
        ),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<TvEpisodesModel>> getEpisodesTv(
      TvEpisodesParameters parameters) async {
    final response = await Dio().get(ApiConstance.tvEpisodesPath(
      seasonNumber: parameters.seasonNumber,
      tvId: parameters.tvEpisodesId,
    ));
    if (response.statusCode == 200) {
      return List<TvEpisodesModel>.from(
        (response.data["episodes"] as List).map(
          (e) => TvEpisodesModel.fromJson(e, response.data),
        ),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
