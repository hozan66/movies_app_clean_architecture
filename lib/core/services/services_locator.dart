import 'package:get_it/get_it.dart';
import '../../movies/domain/usecases/get_movie_details_usecase.dart';

import '../../movies/data/data_source/movie_remote_data_source.dart';
import '../../movies/data/repository/movies_repository.dart';
import '../../movies/domain/repository/base_movies_repository.dart';
import '../../movies/domain/usecases/get_now_playing_movies_usecase.dart';
import '../../movies/domain/usecases/get_popular_movies_usecase.dart';
import '../../movies/domain/usecases/get_recommendation_usecase.dart';
import '../../movies/domain/usecases/get_top_rated_movies_usecase.dart';
import '../../movies/presentation/controller/movie_details_bloc/movie_details_bloc.dart';
import '../../movies/presentation/controller/movies_bloc/movies_bloc.dart';

// What is the use of singleton class in flutter?
// The singleton pattern is a pattern used in object-oriented programming which
// ensures that a class has only one instance and also provides
// a global point of access to it. Sometimes it's important for a class
// to have exactly one instance, or you might force your app into a weird state.

final locator = GetIt.instance;

class ServicesLocator {
  // Create a init() method for creating our services
  // Register all the services that you need
  void init() {
    /// Data source
    locator.registerLazySingleton<BaseMoviesRemoteDataSource>(
      () => MoviesRemoteDataSource(),
    );

    /// Repository
    // pass locator.get<BaseMoviesRemoteDataSource>() or just pass locator()
    locator.registerLazySingleton<BaseMoviesRepository>(
      () => MoviesRepository(
        locator.get<BaseMoviesRemoteDataSource>(),
      ),
    );

    /// Use Cases
    // pass locator.get<BaseMoviesRepository>() or just pass locator()
    locator.registerLazySingleton<GetNowPlayingMoviesUseCase>(
      () => GetNowPlayingMoviesUseCase(
        locator.get<BaseMoviesRepository>(),
      ),
    );

    locator.registerLazySingleton(
      () => GetPopularMoviesUseCase(
        locator.get<BaseMoviesRepository>(),
      ),
    );

    locator.registerLazySingleton(
      () => GetTopRatedMoviesUseCase(
        locator.get<BaseMoviesRepository>(),
      ),
    );

    locator.registerLazySingleton(
      () => GetMovieDetailsUseCase(
        locator.get<BaseMoviesRepository>(),
      ),
    );

    locator.registerLazySingleton(
      () => GetRecommendationUseCase(
        locator.get<BaseMoviesRepository>(),
      ),
    );

    /// Bloc
    // pass locator.get<GetNowPlayingMoviesUseCase>() or just pass locator()
    // locator.registerFactory => will create an object each time we call it.
    locator.registerFactory<MoviesBloc>(
      () => MoviesBloc(
        locator.get<GetNowPlayingMoviesUseCase>(),
        locator.get<GetPopularMoviesUseCase>(),
        locator.get<GetTopRatedMoviesUseCase>(),
      ),
    );

    locator.registerFactory<MovieDetailsBloc>(
      () => MovieDetailsBloc(locator.get<GetMovieDetailsUseCase>(),
          locator.get<GetRecommendationUseCase>()),
    );
  }
}
