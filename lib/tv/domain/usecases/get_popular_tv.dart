import 'package:equatable/equatable.dart';
import 'package:move/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:move/core/usecases/base_usecase.dart';

import 'package:move/tv/domain/entities/tv.dart';
import 'package:move/tv/domain/repository/base_tv_repository.dart';

class GetPopulerTvUsecase extends BassUseCase<List<Tv>, PopularTvParameters> {
  final BaseTvRepository _baseTVRepository;
  GetPopulerTvUsecase(this._baseTVRepository);
  @override
  Future<Either<Failure, List<Tv>>> call(PopularTvParameters parameters) async {
    return await _baseTVRepository.getPopularTv();
  }
}

class PopularTvParameters extends Equatable {
  final int page;
  const PopularTvParameters({required this.page});

  @override
  List<Object?> get props => [
        page,
      ];
}
