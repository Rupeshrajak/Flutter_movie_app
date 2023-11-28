import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/common/page_status.dart';
import 'package:hrms/top_rated/bloc/top_rated_event.dart';
import 'package:hrms/top_rated/bloc/top_rated_repository.dart';
import 'package:hrms/top_rated/model/top_rated_movie.dart';
import '../../Api/exception/app_exceptions.dart';

import 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  TopRatedRepository repository;

  TopRatedBloc(this.repository)
      : super(const TopRatedState(pageStatus: PageStatus.initial)) {
    on<FetchTopRatedMovieDetailsEvent>(_mapFetchTopRatedMovieDetailsEventToState);
  }

  Future<void> _mapFetchTopRatedMovieDetailsEventToState(
      FetchTopRatedMovieDetailsEvent event,
      Emitter<TopRatedState> emitter) async {
    emitter(state.copyWith(status: PageStatus.loading));

    try {
      TopRatedMovie moviesDetails =
          await repository.callTopRatedMovieDetailsApi();
      List<Results> movieDetailsList = moviesDetails.results!
          .where((element) =>
              element.originalTitle!.toLowerCase().contains(event.key.toLowerCase()))
          .toList() ?? [];
      emitter(TopRatedMovieListLoadedState(movieDetailsList,
          pageStatus: PageStatus.success));
    } catch (ex) {
      if (ex is UnauthorizedException) {
        emitter(state.copyWith(status: PageStatus.unAuthorized));
      } else {
        emitter(
            state.copyWith(status: PageStatus.failure, message: ex.toString()));
      }
    }
  }
}
