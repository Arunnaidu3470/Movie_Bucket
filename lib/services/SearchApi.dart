import '../constants/Keys.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

enum SearchType { company, collection, keyword, movie, multi, person, tv }

class SearchServices {
  static final String _apiKey = Keys.TMDB_API_KEY;
  static final String _baseUrl = 'https://api.themoviedb.org/3/search';
  static Future searchMovie(String query) async {
    String url = '$_baseUrl/multi?api_key=$_apiKey&page=1&query=$query';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data['results'];
  }
}
