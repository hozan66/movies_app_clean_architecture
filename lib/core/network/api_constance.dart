class ApiConstance {
  // 'https://api.themoviedb.org/3/movie/now_playing?api_key=23d3d15a5830f0099815a2b98cdfa8f8';
  static const String baseUrl = 'https://api.themoviedb.org/3';

  static const String apiKey = '23d3d15a5830f0099815a2b98cdfa8f8';

  static const String nowPlayingMoviesPath =
      '$baseUrl/movie/now_playing?api_key=$apiKey';

  static const String popularMoviesPath =
      '$baseUrl/movie/popular?api_key=$apiKey';

  static const String topRatedMoviesPath =
      '$baseUrl/movie/top_rated?api_key=$apiKey';

  // https://api.themoviedb.org/3/movie/438148?api_key=23d3d15a5830f0099815a2b98cdfa8f8
  static String movieDetailsPath(int movieId) =>
      '$baseUrl/movie/$movieId?api_key=$apiKey';

  static String recommendationPath(int movieId) =>
      '$baseUrl/movie/$movieId/recommendations?api_key=$apiKey';

  // https://image.tmdb.org/t/p/w500/2RSirqZG949GuRwN38MYCIGG4Od.jpg
  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';

  static String imageUrl(String path) => '$baseImageUrl$path';
}
