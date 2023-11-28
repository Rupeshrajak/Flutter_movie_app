import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/common/page_status.dart';
import 'package:hrms/now_playing/bloc/now_playing_event.dart';
import 'package:hrms/now_playing/bloc/now_playing_repository.dart';
import 'package:hrms/now_playing/model/Movie_list.dart';
import '../../Api/exception/app_exceptions.dart';

import 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  NowPlayingRepository repository;

  NowPlayingBloc(this.repository)
      : super(const NowPlayingState(pageStatus: PageStatus.initial)) {
    on<FetchNowPlayingMovieListEvent>(_mapFetchNowPlayingMovieListEventToState);
  }

  Future<void> _mapFetchNowPlayingMovieListEventToState(
      FetchNowPlayingMovieListEvent event,
      Emitter<NowPlayingState> emitter) async {
    emitter(state.copyWith(status: PageStatus.loading));

    try {
      MovieList moviesDetails =
          await repository.callRecentPlayMoviesDetailsApi();
      List<Results> movieDetailsList = moviesDetails.results!
          .where((element) =>
              element.originalTitle!.toLowerCase().contains(event.key.toLowerCase()))
          .toList() ?? [];
      emitter(MovieListLoadedState(movieDetailsList,
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
