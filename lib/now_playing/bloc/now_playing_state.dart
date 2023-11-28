import 'package:equatable/equatable.dart';
import 'package:hrms/now_playing/model/Movie_list.dart';


import '../../common/page_status.dart';

class NowPlayingState extends Equatable {
  final String? message;
  final PageStatus pageStatus;

  const NowPlayingState({required this.pageStatus, this.message = ""});

  @override
  List<Object?> get props => [pageStatus, message];

  NowPlayingState copyWith({PageStatus? status, String? message}) {
    return NowPlayingState(
        pageStatus: status ?? pageStatus, message: message ?? this.message);
  }
}


class MovieListLoadedState extends NowPlayingState {
  final List<Results> movieDetails;

  const MovieListLoadedState(this.movieDetails,
      {required super.pageStatus, super.message});

  List<Object?> get props => [movieDetails];
}

