import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String? backdropPath;
  final String overview;
  final List<int> genreIds;
  final double voteAverage;
  final String releaseDate;

  const Movie({
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.overview,
    required this.genreIds,
    required this.voteAverage,
    required this.releaseDate,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        backdropPath,
        overview,
        genreIds,
        voteAverage,
        releaseDate,
      ];

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     other is Movie &&
  //         runtimeType == other.runtimeType &&
  //         id == other.id &&
  //         title == other.title &&
  //         backdropPath == other.backdropPath &&
  //         voteAverage == other.voteAverage &&
  //         genreIds == other.genreIds &&
  //         overview == other.overview;

  // @override
  // int get hashCode =>
  //     id.hashCode ^
  //     title.hashCode ^
  //     backdropPath.hashCode ^
  //     voteAverage.hashCode ^
  //     genreIds.hashCode ^
  //     overview.hashCode;
}
