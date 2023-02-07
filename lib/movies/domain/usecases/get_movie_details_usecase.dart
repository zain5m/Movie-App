import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:move/core/error/failure.dart';
import 'package:move/core/usecases/base_usecase.dart';
import 'package:move/movies/domain/entities/movie.dart';
import 'package:move/movies/domain/entities/movie_detail.dart';
import 'package:move/movies/domain/repository/base_movies_repository.dart';

class GetMovieDetailsUseCase
    extends BassUseCase<MovieDetail, MovieDetailsParameters> {
  final BaseMoviesRepository baseMoviesRepository;

  GetMovieDetailsUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, MovieDetail>> call(
      MovieDetailsParameters parameters) async {
    return await baseMoviesRepository.getMovieDetails(parameters);
  }
}

class MovieDetailsParameters extends Equatable {
  final int movieId;
  const MovieDetailsParameters({
    required this.movieId,
  });

  @override
  List<Object?> get props => [
        movieId,
      ];
}
