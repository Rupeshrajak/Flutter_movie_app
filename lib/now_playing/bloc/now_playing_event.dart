import 'package:equatable/equatable.dart';

abstract class NowPlayingEvent extends Equatable {}

class FetchNowPlayingMovieListEvent extends NowPlayingEvent {
  final String key;

  FetchNowPlayingMovieListEvent(this.key);

  @override
  List<Object?> get props => [];
}
