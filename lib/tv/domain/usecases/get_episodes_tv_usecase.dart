import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:move/core/error/failure.dart';
import 'package:move/core/usecases/base_usecase.dart';
import 'package:move/tv/domain/entities/tv_episodes.dart';
import 'package:move/tv/domain/repository/base_tv_repository.dart';

class GetEpisodesTvUseCase
    extends BassUseCase<List<TvEpisodes>, TvEpisodesParameters> {
  final BaseTvRepository _baseTvRepository;

  GetEpisodesTvUseCase(this._baseTvRepository);
  @override
  Future<Either<Failure, List<TvEpisodes>>> call(
      TvEpisodesParameters parameters) async {
    return await _baseTvRepository.getEpisodesTv(parameters);
  }
}

class TvEpisodesParameters extends Equatable {
  final int seasonNumber;
  final int tvEpisodesId;

  const TvEpisodesParameters({
    required this.seasonNumber,
    required this.tvEpisodesId,
  });
  @override
  List<Object?> get props => [
        seasonNumber,
        tvEpisodesId,
      ];
}
