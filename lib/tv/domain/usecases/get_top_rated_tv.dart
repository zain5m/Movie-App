import 'package:move/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:move/core/usecases/base_usecase.dart';
import 'package:move/tv/domain/entities/tv.dart';
import 'package:move/tv/domain/repository/base_tv_repository.dart';

class GetTopRatedTvUsecase extends BassUseCase<List<Tv>, NoParameters> {
  final BaseTvRepository _baseTVRepository;

  GetTopRatedTvUsecase(this._baseTVRepository);
  @override
  Future<Either<Failure, List<Tv>>> call(NoParameters parameters) async {
    return await _baseTVRepository.getTopRatedTv();
  }
}
