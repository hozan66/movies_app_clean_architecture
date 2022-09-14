import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../entities/movie.dart';
import '../repository/base_movies_repository.dart';

// What are callable classes in Dart?
// Dart allows the user to create a callable class which allows
// the instance of the class to be called as a function.
// To allow an instance of your Dart class to be called like a function,
// implement the call() method.

// GetPopularMoviesUseCase() will automatically call the call() method.
class GetPopularMoviesUseCase extends BaseUseCase<List<Movie>, NoParameters> {
  // Getting a reference from BaseMoviesRepository class
  // We can't take an object form BaseMoviesRepository class because it's abstract class
  // we can call this statement => dependency injection
  final BaseMoviesRepository baseMoviesRepository;

  GetPopularMoviesUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParameters parameters) async {
    return await baseMoviesRepository.getPopularMovies();
  }
}
