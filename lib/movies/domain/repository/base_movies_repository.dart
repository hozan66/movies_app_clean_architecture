// SOLID principles
//
// Layer can talk with another layer
// dependency inversion principle
// This abstract class should not have implementation (body)
//
// The Dependency Inversion Principle (DIP) states that high-level
// modules should not depend on low-level modules; both should depend on abstractions.
// Abstractions should not depend on details.

import 'package:dartz/dartz.dart';
import 'package:movies_app_clean_architecture/movies/domain/usecases/get_movie_details_usecase.dart';

import '../../../core/error/failure.dart';
import '../entities/movie.dart';
import '../entities/movie_details.dart';
import '../entities/recommendation.dart';
import '../usecases/get_recommendation_usecase.dart';

// Just contract and abstract class.
abstract class BaseMoviesRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  Future<Either<Failure, List<Movie>>> getPopularMovies();

  Future<Either<Failure, List<Movie>>> getTopRatedMovies();

  Future<Either<Failure, MovieDetails>> getMovieDetails(
      MovieDetailsParameters parameters);

  Future<Either<Failure, List<Recommendation>>> getRecommendation(
      RecommendationParameters parameters);
}
