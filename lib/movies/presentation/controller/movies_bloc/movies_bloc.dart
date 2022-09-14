import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/usecases/get_now_playing_movies_usecase.dart';
import 'movies_event.dart';
import 'movies_state.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../../domain/usecases/get_popular_movies_usecase.dart';
import '../../../domain/usecases/get_top_rated_movies_usecase.dart';

// import '../../../core/services/services_locator.dart';

// All logic is here
class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;

  MoviesBloc(
    this.getNowPlayingMoviesUseCase,
    this.getPopularMoviesUseCase,
    this.getTopRatedMoviesUseCase,
  ) : super(const MoviesState()) {
    // Listening to (receiving) the events
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);
    //=====================================
    on<GetPopularMoviesEvent>(_getPopularMovies);
    //=====================================
    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
  }

  FutureOr<void> _getNowPlayingMovies(
      GetNowPlayingMoviesEvent event, Emitter<MoviesState> emit) async {
    // log(locator.get<GetNowPlayingMoviesUseCase>().hashCode.toString());

    // Using NowPlaying useCase
    final result = await getNowPlayingMoviesUseCase(
        const NoParameters()); // Callable class
    log('========================');
    log(result.toString());

    // L => left for failure
    // R => right for success
    result.fold(
      (left) => emit(
        state.copyWith(
          nowPlayingState: RequestState.error,
          nowPlayingMessage: left.message,
        ),
      ),
      (rightList) => emit(
        state.copyWith(
          nowPlayingState: RequestState.loaded,
          nowPlayingMovies: rightList,
        ),
      ),
    );
  }

  FutureOr<void> _getPopularMovies(
      GetPopularMoviesEvent event, Emitter<MoviesState> emit) async {
    // Using Popular useCase
    final result =
        await getPopularMoviesUseCase(const NoParameters()); // Callable class
    log('========================');
    log(result.toString());

    // L => left for failure
    // R => right for success
    result.fold(
      (left) => emit(
        state.copyWith(
          popularState: RequestState.error,
          popularMessage: left.message,
        ),
      ),
      (rightList) => emit(
        state.copyWith(
          popularState: RequestState.loaded,
          popularMovies: rightList,
        ),
      ),
    );
  }

  FutureOr<void> _getTopRatedMovies(
      GetTopRatedMoviesEvent event, Emitter<MoviesState> emit) async {
    // Using TopRated useCase
    final result =
        await getTopRatedMoviesUseCase(const NoParameters()); // Callable class
    log('========================');
    log(result.toString());

    // L => left for failure
    // R => right for success
    result.fold(
      (left) => emit(
        state.copyWith(
          topRatedState: RequestState.error,
          topRatedMessage: left.message,
        ),
      ),
      (rightList) => emit(
        state.copyWith(
          topRatedState: RequestState.loaded,
          topRatedMovies: rightList,
        ),
      ),
    );
  }
}
