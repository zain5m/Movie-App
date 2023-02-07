import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:move/core/error/failure.dart';
import 'package:move/core/usecases/base_usecase.dart';
import 'package:move/movies/domain/entities/movie.dart';
import 'package:move/movies/domain/repository/base_movies_repository.dart';

class GetPopularMoviesUseCase
    extends BassUseCase<List<Movie>, PopularMoviesParameters> {
  final BaseMoviesRepository baseMoviesRepository;

  GetPopularMoviesUseCase(this.baseMoviesRepository);
  @override
  Future<Either<Failure, List<Movie>>> call(
      PopularMoviesParameters parameters) async {
    return baseMoviesRepository.getPopularMovies(parameters);
  }
}

class PopularMoviesParameters extends Equatable {
  final int page;
  const PopularMoviesParameters({required this.page});

  @override
  List<Object?> get props => [
        page,
      ];
}
