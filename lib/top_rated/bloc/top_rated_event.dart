import 'package:equatable/equatable.dart';

abstract class TopRatedEvent extends Equatable {}

class FetchTopRatedMovieDetailsEvent extends TopRatedEvent {
  final String key;

  FetchTopRatedMovieDetailsEvent(this.key);

  @override
  List<Object?> get props => [];
}
