class ApiConstance {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const appkey = 'efd62e257c5db7d91d09a4e8d4aea1c3';
  //
  static const String nowPlayingMoviesPath =
      '$baseUrl/movie/now_playing?api_key=$appkey';
  static String popularMoviesPath({required int? page}) =>
      '$baseUrl/movie/popular?api_key=$appkey&page=$page';
  static String topRatedPath({required int? page}) =>
      '$baseUrl/movie/top_rated?api_key=$appkey&page=$page';
//
  static String movieDetailsPath(int movieId) =>
      "$baseUrl/movie/$movieId?api_key=$appkey";
  static String movieRecommendationPath(int movieId) =>
      "$baseUrl/movie/$movieId/recommendations?api_key=$appkey";

// !TV
  static const String onTheAirPath = '$baseUrl/tv/on_the_air?api_key=$appkey';
  static const String popularTvPath = '$baseUrl/tv/popular?api_key=$appkey';
  static const String topRatedTvPath = '$baseUrl/tv/top_rated?api_key=$appkey';
//
  static String tvDetailsPath(int tvId) => "$baseUrl/tv/$tvId?api_key=$appkey";

  static String tvRecommendationPath(int tvId) =>
      "$baseUrl/tv/$tvId/recommendations?api_key=$appkey";

  static String tvEpisodesPath(
          {required int tvId, required int seasonNumber}) =>
      "$baseUrl/tv/$tvId/season/$seasonNumber?api_key=$appkey";

//

  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
  static String imageUrl(String path) => "$baseImageUrl$path";
}
