import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:move/core/error/failure.dart';
import 'package:move/core/usecases/base_usecase.dart';
import 'package:move/movies/domain/entities/recommendation.dart';
import 'package:move/movies/domain/repository/base_movies_repository.dart';

class RecommendationUseCase
    extends BassUseCase<List<Recommendation>, RecommendationParameters> {
  final BaseMoviesRepository baseMoviesRepository;

  RecommendationUseCase(this.baseMoviesRepository);
  @override
  Future<Either<Failure, List<Recommendation>>> call(
      RecommendationParameters parameters) async {
    return await baseMoviesRepository.getRecommendation(parameters);
  }
}

class RecommendationParameters extends Equatable {
  final int id;
  const RecommendationParameters({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}
