import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/enums.dart';

import '../../../domain/entities/movie_details.dart';
import '../../../domain/entities/recommendation.dart';
import '../../../domain/usecases/get_movie_details_usecase.dart';
import '../../../domain/usecases/get_recommendation_usecase.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetRecommendationUseCase getRecommendationUseCase;

  MovieDetailsBloc(this.getMovieDetailsUseCase, this.getRecommendationUseCase)
      : super(const MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
    on<GetMovieRecommendationEvent>(_getMovieRecommendation);
  }

  FutureOr<void> _getMovieDetails(
      GetMovieDetailsEvent event, Emitter<MovieDetailsState> emit) async {
    // Using MovieDetails useCase
    final result = await getMovieDetailsUseCase(
        MovieDetailsParameters(movieId: event.id)); // Callable class
    log('========================');
    log(result.toString());

    // L => left for failure
    // R => right for success
    result.fold(
      (left) => emit(
        state.copyWith(
          movieDetailsState: RequestState.error,
          movieDetailsMessage: left.message,
        ),
      ),
      (right) => emit(
        state.copyWith(
          movieDetailsState: RequestState.loaded,
          movieDetails: right,
        ),
      ),
    );
  }

  FutureOr<void> _getMovieRecommendation(GetMovieRecommendationEvent event,
      Emitter<MovieDetailsState> emit) async {
    // Using MovieRecommendation useCase
    final result = await getRecommendationUseCase(
        RecommendationParameters(event.id)); // Callable class
    log('========================');
    log(result.toString());

    // L => left for failure
    // R => right for success
    result.fold(
      (left) => emit(
        state.copyWith(
          recommendationState: RequestState.error,
          recommendationMessage: left.message,
        ),
      ),
      (rightList) => emit(
        state.copyWith(
          recommendationState: RequestState.loaded,
          recommendation: rightList,
        ),
      ),
    );
  }
}
