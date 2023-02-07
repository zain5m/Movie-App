import 'package:equatable/equatable.dart';
import 'package:move/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:move/core/usecases/base_usecase.dart';
import 'package:move/tv/domain/entities/tv.dart';
import 'package:move/tv/domain/repository/base_tv_repository.dart';

class GetTopRatedTvUsecase extends BassUseCase<List<Tv>, TopRatedTvParameters> {
  final BaseTvRepository _baseTVRepository;

  GetTopRatedTvUsecase(this._baseTVRepository);
  @override
  Future<Either<Failure, List<Tv>>> call(
      TopRatedTvParameters parameters) async {
    return await _baseTVRepository.getTopRatedTv();
  }
}

class TopRatedTvParameters extends Equatable {
  final int page;
  const TopRatedTvParameters({required this.page});

  @override
  List<Object?> get props => [
        page,
      ];
}
