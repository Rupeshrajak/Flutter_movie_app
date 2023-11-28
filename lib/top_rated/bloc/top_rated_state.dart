import 'package:equatable/equatable.dart';
import 'package:hrms/top_rated/model/top_rated_movie.dart';


import '../../common/page_status.dart';

class TopRatedState extends Equatable {
  final String? message;
  final PageStatus pageStatus;

  const TopRatedState({required this.pageStatus, this.message = ""});

  @override
  List<Object?> get props => [pageStatus, message];

  TopRatedState copyWith({PageStatus? status, String? message}) {
    return TopRatedState(
        pageStatus: status ?? pageStatus, message: message ?? this.message);
  }
}

class TopRatedMovieListLoadedState extends TopRatedState {
  final List<Results> movieDetails;

  const TopRatedMovieListLoadedState(this.movieDetails,
      {required super.pageStatus, super.message});

  List<Object?> get props => [movieDetails];
}
