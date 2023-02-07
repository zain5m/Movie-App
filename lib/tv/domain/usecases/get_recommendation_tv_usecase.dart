import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:move/core/error/failure.dart';
import 'package:move/core/usecases/base_usecase.dart';
import 'package:move/tv/domain/entities/tv_recommendation.dart';
import 'package:move/tv/domain/repository/base_tv_repository.dart';

class GetRecommendationTvUseCase
    extends BassUseCase<List<TvRecommendation>, TvRecommendationParameters> {
  final BaseTvRepository _baseTvRepository;
  GetRecommendationTvUseCase(this._baseTvRepository);
  @override
  Future<Either<Failure, List<TvRecommendation>>> call(
      TvRecommendationParameters parameters) async {
    return await _baseTvRepository.getRecommendationTv(parameters);
  }
}

class TvRecommendationParameters extends Equatable {
  final int tvRecommendationId;
  const TvRecommendationParameters({
    required this.tvRecommendationId,
  });

  @override
  List<Object?> get props => [
        tvRecommendationId,
      ];
}
