import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/Keys.dart';

class PeopleServices {
  ///contains services of actors

  static final String _apiKey = Keys.API_V3;
  static final String _baseUrl = 'https://api.themoviedb.org/3/person';

  static Future getPeopleDetailsById(int castId,
      {String language = 'en'}) async {
    ///returns a [Map<String,dynamic>] of People details
    String url = '$_baseUrl/$castId?api_key=$_apiKey&language=$language';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data;
  }

  static Future getPeopleMovieCreditsById(int castId,
      {String language = 'en'}) async {
    ///returns a [List] of credits fro each movie
    String url =
        '$_baseUrl/$castId/movie_credits?api_key=$_apiKey&language=$language';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['cast'];
  }

  static Future getPeopleTaggedImagesById(int castId,
      {String language = 'en', int page = 1}) async {
    ///returns a [List] of credits fro each movie
    String url =
        '$_baseUrl/$castId/tagged_images?api_key=$_apiKey&language=$language&page=$page';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['results'];
  }

  static Future getPeopleImagesById(int castId,
      {String language = 'en', int page = 1}) async {
    ///returns a [List] of credits fro each movie
    String url = '$_baseUrl/$castId/images?api_key=$_apiKey';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['profiles'];
  }
}
