import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:move/core/error/failure.dart';

import 'package:move/core/usecases/base_usecase.dart';
import 'package:move/tv/domain/entities/tv_details.dart';
import 'package:move/tv/domain/repository/base_tv_repository.dart';

class GetTvDetailsUseCase extends BassUseCase<TvDetails, TvDetailsParameters> {
  final BaseTvRepository _baseTvRepository;
  GetTvDetailsUseCase(this._baseTvRepository);
  @override
  Future<Either<Failure, TvDetails>> call(
      TvDetailsParameters parameters) async {
    return await _baseTvRepository.getTvDetails(parameters);
  }
}

class TvDetailsParameters extends Equatable {
  final int tvId;
  const TvDetailsParameters({
    required this.tvId,
  });

  @override
  List<Object?> get props => [
        tvId,
      ];
}
