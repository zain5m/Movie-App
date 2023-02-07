import 'package:equatable/equatable.dart';

class Seasons extends Equatable {
  final int episodeCount;
  final int id;
  final String name;
  final int seasonNumber;

  const Seasons({
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.seasonNumber,
  });
  @override
  List<Object?> get props => [
        episodeCount,
        id,
        name,
        seasonNumber,
      ];
}
