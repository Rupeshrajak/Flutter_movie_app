import 'package:dio/dio.dart';
import 'package:hrms/now_playing/model/Movie_list.dart';

import '../../Api/api_client.dart';

class NowPlayingRepository {
  ApiClient apiClient;

  NowPlayingRepository(this.apiClient);

  Future<MovieList> callRecentPlayMoviesDetailsApi() async {
    Response response = await apiClient.getNowPlayingMovieDetails();
    MovieList moviesDetails = MovieList.fromJson(response.data);
    return moviesDetails;
  }
}
