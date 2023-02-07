import 'package:get_it/get_it.dart';
import 'package:move/core/blocApp/app_bloc.dart';
import 'package:move/core/utils/size_config.dart';
import 'package:move/movies/data/datasource/movie_remote-data_scource.dart';
import 'package:move/movies/data/repository/movies_repository.dart';
import 'package:move/movies/domain/repository/base_movies_repository.dart';
import 'package:move/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:move/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:move/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:move/movies/domain/usecases/get_recommendation_usecase.dart';
import 'package:move/movies/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:move/movies/presentation/controller/bloc_movies/movies_bloc.dart';
import 'package:move/movies/presentation/controller/bloc_movies_details/movie_details_bloc.dart';
import 'package:move/movies/presentation/controller/bloc_see_more/see_more_bloc.dart';
import 'package:move/tv/data/datasource/tv_remote_data_source.dart';
import 'package:move/tv/data/repository/tv_repository.dart';
import 'package:move/tv/domain/repository/base_tv_repository.dart';
import 'package:move/tv/domain/usecases/get_episodes_tv_usecase.dart';
import 'package:move/tv/domain/usecases/get_on_the_air_tv.dart';
import 'package:move/tv/domain/usecases/get_popular_tv.dart';
import 'package:move/tv/domain/usecases/get_recommendation_tv_usecase.dart';
import 'package:move/tv/domain/usecases/get_top_rated_tv.dart';
import 'package:move/tv/domain/usecases/get_tv_details_usecase.dart';
import 'package:move/tv/presentation/controller/bloc/tv_bloc.dart';
import 'package:move/tv/presentation/controller/details_bloc/details_bloc.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
//! BLoc

    sl.registerFactory(() => MoviesBloc(sl(), sl(), sl()));
    //
    sl.registerFactory(() => MovieDetailsBloc(sl(), sl()));

    //

    sl.registerFactory(() => TvBloc(sl(), sl(), sl()));
    sl.registerFactory(() => TvDetailsBloc(sl(), sl(), sl()));
    //
    sl.registerFactory(() => AppBloc());
    //
    sl.registerFactory(() => SeeMoreBloc(sl(), sl()));

//! UseCasre
    sl.registerLazySingleton(() => GetNowPlayingMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetPopularMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetTopRatedMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetMovieDetailsUseCase(sl()));
    sl.registerLazySingleton(() => RecommendationUseCase(sl()));
    //
    sl.registerLazySingleton(() => GetOnTheAirTvUsecase(sl()));
    sl.registerLazySingleton(() => GetPopulerTvUsecase(sl()));
    sl.registerLazySingleton(() => GetTopRatedTvUsecase(sl()));
    sl.registerLazySingleton(() => GetTvDetailsUseCase(sl()));
    sl.registerLazySingleton(() => GetRecommendationTvUseCase(sl()));
    sl.registerLazySingleton(() => GetEpisodesTvUseCase(sl()));

// !Repository
    sl.registerLazySingleton<BaseMoviesRepository>(
        () => MoviesRepository(sl()));
    //
    sl.registerLazySingleton<BaseTvRepository>(() => TvRebository(sl()));

// !Data Sours
    sl.registerLazySingleton<BaseMovieRemoteDataSource>(
        () => MovieRemoteDataSource());
    //
    sl.registerLazySingleton<BaseTvRemoteDataSource>(
        () => TvRemoteDataSource());
  }
}
