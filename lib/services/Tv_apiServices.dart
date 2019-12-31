import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/Keys.dart';

class TVServices {
  static final String _apiKey = Keys.TMDB_API_KEY;
  static final String _baseUrl = 'https://api.themoviedb.org/3/tv';

  /// Get Popular Tv shows as Map<String,dynamic>
  /// Optional parameters [page],[language]
  static Future getPopularShows(
      {int page = 1, String language = 'en-US'}) async {
    String url =
        '$_baseUrl/popular?api_key=$_apiKey&language=$language&page=$page';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data;
  }

  ///Get the primary TV show details by id.
  /// Get Show details as Map<String,dynamic>
  /// Optional parameters [language] default en-US
  static Future getShowDetailsById(int showId,
      {String language = 'en-US'}) async {
    String url = '$_baseUrl/$showId?api_key=$_apiKey&language=$language';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data;
  }

  ///Get a list of TV shows that are airing today.
  ///This query is purely day based as we do not currently support airing times.
  static Future getAiringToday(
      {int page = 1, String language = 'en-US'}) async {
    String url =
        '$_baseUrl/airing_today?api_key=$_apiKey&language=$language&page=$page';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['results'];
  }

  ///Get a list of shows that are currently on the air.
  ///This query looks for any TV show that has an episode with an air date in the next 7 days.
  static Future getOnGoingShow(
      {int page = 1, String language = 'en-US'}) async {
    String url =
        '$_baseUrl/on_the_air?api_key=$_apiKey&language=$language&page=$page';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['results'];
  }

  ///Get a list of the top rated TV shows on TMDb.
  static Future getTopRated({int page = 1, String language = 'en-US'}) async {
    String url =
        '$_baseUrl/top_rated?api_key=$_apiKey&language=$language&page=$page';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['results'];
  }

  ///Get a list of the top rated TV shows on TMDb.
  static Future getSeasonDetailsById(int tvId, int seasonNumber,
      {int page = 1, String language = 'en-US'}) async {
    String url =
        '$_baseUrl/$tvId/season/$seasonNumber?api_key=$_apiKey&language=$language';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['episodes'];
  }
}
