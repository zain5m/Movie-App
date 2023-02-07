import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:move/core/error/failure.dart';
import 'package:move/core/usecases/base_usecase.dart';
import 'package:move/movies/domain/entities/movie.dart';
import 'package:move/movies/domain/repository/base_movies_repository.dart';

class GetTopRatedMoviesUseCase
    extends BassUseCase<List<Movie>, TopRatedMoviesParameters> {
  final BaseMoviesRepository baseMoviesRepository;

  GetTopRatedMoviesUseCase(this.baseMoviesRepository);
  @override
  Future<Either<Failure, List<Movie>>> call(
      TopRatedMoviesParameters parameters) async {
    return baseMoviesRepository.getTopRatedMoveis(parameters);
  }
}

class TopRatedMoviesParameters extends Equatable {
  final int page;
  const TopRatedMoviesParameters({required this.page});

  @override
  List<Object?> get props => [
        page,
      ];
}
