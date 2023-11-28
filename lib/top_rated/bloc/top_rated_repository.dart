import 'package:dio/dio.dart';
import 'package:hrms/now_playing/model/Movie_list.dart';

import '../../Api/api_client.dart';
import '../model/top_rated_movie.dart';

class TopRatedRepository {
  ApiClient apiClient;

  TopRatedRepository(this.apiClient);

  Future<TopRatedMovie> callTopRatedMovieDetailsApi() async {
    Response response = await apiClient.getTopRatedMovieDetails();
    TopRatedMovie moviesDetails = TopRatedMovie.fromJson(response.data);
    return moviesDetails;
  }
}
