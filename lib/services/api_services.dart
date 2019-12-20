import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/Keys.dart';

class APIBase {
  static const TMDB_BASE_URL = 'https://api.themoviedb.org/3';
  static const TMDB_BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/original';
}

class APIServices {
  static final String _apiKey = Keys.TMDB_API_KEY;

  ///gets the top movies of Present time by default
  static Future getLatestMovies(
      {String language = 'en', bool adult = false, int year = 2020}) async {
    var dat = DateTime.now();
    if (year == 0 || year == null) year = dat.year;
    String url =
        '${APIBase.TMDB_BASE_URL}/discover/movie?api_key=$_apiKey&$language&sort_by=popularity.desc&include_adult=' +
            adult.toString() +
            'primary_release_year=${(year - 1).toString()}&year=${year.toString()}' +
            '&include_video=false&page=1';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['results'];
  }

  static String getImageUrlOfMovie(String path) {
    return '${APIBase.TMDB_BASE_IMAGE_URL}$path';
  }

  ///grturns youtube url
  static String getYoutubeUrl(String youtubeid) {
    return 'https://www.youtube.com/watch?v=$youtubeid';
  }
}

class MovieServices extends APIBase {
  static final String _apiKey = Keys.TMDB_API_KEY;

  ///to Query movies by [id]
  static Future getMovieById(
      {@required String id, String language = 'en'}) async {
    String url =
        '${APIBase.TMDB_BASE_URL}/movie/$id?api_key=$_apiKey&language=$language';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data;
  }

  ///to Query movies by [title]
  static Future getMovieByTitle(
      {@required String title, String language = 'en'}) async {
    String url =
        '${APIBase.TMDB_BASE_URL}/movie/$title?api_key=$_apiKey&language=$language';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data;
  }

  ///to Query external ids of movie with [movie id]
  static Future getExternalIdsOfMovies({@required String id}) async {
    String url =
        '${APIBase.TMDB_BASE_URL}/movie/$id/external_ids?api_key=$_apiKey';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data; //returnes body of the ids in json formate
  }

  static Future getMoviesNowPlaying(
      {String language = 'en', String region = 'us'}) async {
    String url =
        '${APIBase.TMDB_BASE_URL}/movie/now_playing?api_key=$_apiKey&language=$language&page=1&region=$region';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['results']; //returnes body of the ids in json formate
  }

  ///returns a list of upcoming movies default [region] is USA
  static Future getMoviesUpComing(
      {String language = 'en', String region = 'us'}) async {
    String url =
        '${APIBase.TMDB_BASE_URL}/movie/upcoming?api_key=$_apiKey&language=en-US&page=1&region=$region';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['results']; //returnes body of the ids in json formate
  }

  ///returns a list of upcoming movies default [region] is USA
  static Future getMoviesTopRated(
      {String language = 'en', String region = 'us'}) async {
    String url =
        '${APIBase.TMDB_BASE_URL}/movie/top_rated?api_key=$_apiKey&language=$language&page=1&reagion=$region';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['results']; //returnes body of the ids in json formate
  }

  ///returns a list of avaliable videos by id
  static Future getMoviesVideosById(String id,
      {String language = 'en', String region = 'us'}) async {
    String url =
        '${APIBase.TMDB_BASE_URL}/movie/$id/videos?api_key=$_apiKey&language=en-US';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['results']; //returnes body of the ids in json formate
  }

  ///returns Youtube Trailer id
  static Future getMovieYtTrailerIdById(String id) async {
    try {
      String url =
          '${APIBase.TMDB_BASE_URL}/movie/$id/videos?api_key=$_apiKey&language=en-US';
      http.Response response = await http.get(url);
      var data = jsonDecode(response.body);
      String ytUrl =
          'https://www.youtube.com/watch?v=${data['results'][0]['key']}';
      return data['results'][0]['key'];
    } on RangeError {
      return null;
    } catch (e) {}
    return null;
  }

  ///Returns Youtube Trailer URL
  static Future getMovieYtTrailerUrlById(String id) async {
    try {
      String url =
          '${APIBase.TMDB_BASE_URL}/movie/$id/videos?api_key=$_apiKey&language=en-US';
      http.Response response = await http.get(url);
      var data = jsonDecode(response.body);
      String ytUrl =
          'https://www.youtube.com/watch?v=${data['results'][0]['key']}';
      return ytUrl;
    } on RangeError {
      return null;
    } catch (e) {}
    return null;
  }

  ///returns Cast's List<dynamic> details by taking [movieid]
  static Future getMovieCastDetails(String movieid) async {
    String url =
        '${APIBase.TMDB_BASE_URL}/movie/$movieid/credits?api_key=$_apiKey';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['cast'];
  }

  ///returns Crew's List<dynamic> details by taking [movieid]
  static Future getMovieCrewDetails(String movieid) async {
    String url =
        '${APIBase.TMDB_BASE_URL}/movie/$movieid/credits?api_key=$_apiKey';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['crew'];
  }

  static Future getSimilarMovies(String movieid,
      {String language = 'en', int page = 1}) async {
    String url =
        'https://api.themoviedb.org/3/movie/$movieid/similar?api_key=$_apiKey&language=in&page=1';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['results'];
  }
}

class TvServices {
  static final String _apiKey = Keys.TMDB_API_KEY;

  ///to Query movies by [id]
  static Future getTvById({@required String id, String language = 'en'}) async {
    String url =
        '${APIBase.TMDB_BASE_URL}/movie/$id?api_key=$_apiKey&language=$language';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data;
  }

  ///to Query movies by [title]
  static Future getTvByTitle(
      {@required String title, String language = 'en'}) async {
    String url =
        '${APIBase.TMDB_BASE_URL}/movie/$title?api_key=$_apiKey&language=$language';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data;
  }

  ///to Query external ids of movie with [movie id]
  static Future getExternalIdsOfTv({@required String id}) async {
    String url =
        '${APIBase.TMDB_BASE_URL}/movie/$id/external_ids?api_key=$_apiKey';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data; //returnes body of the ids in json formate
  }

  static Future getTvNowAir(
      {String language = 'en', String region = 'us'}) async {
    String url =
        '${APIBase.TMDB_BASE_URL}/tv/on_the_air?api_key=$_apiKey&language=$language&page=1';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['results']; //returnes body of the ids in json formate
  }

  ///returns a list of upcoming movies default [region] is USA
  static Future getTvPopular(
      {String language = 'en', String region = 'us'}) async {
    String url =
        '${APIBase.TMDB_BASE_URL}/tv/popular?api_key=$_apiKey&language=$language&page=1';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['results']; //returnes body of the ids in json formate
  }

  ///returns a list of upcoming movies default [region] is USA
  static Future getTvTopRated(
      {String language = 'en', String region = 'us'}) async {
    String url =
        '${APIBase.TMDB_BASE_URL}/tv/popular?api_key=$_apiKey&language=$language&page=1';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['results']; //returnes body of the ids in json formate
  }
}
