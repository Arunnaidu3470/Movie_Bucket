import 'package:tmdb_api/tmdb_api.dart';

import '../keys/keys.dart';
import '../../models/models.dart';

class MovieApi {
  // imports version 3
  V3 _tmdbV3 = TMDB(
    ApiKeys(Keys.API_V3, Keys.API_V4),
    logConfig: ConfigLogger.showAll(),
  ).v3;

  Future<List<MovieModel>> getPopularMovies() async {
    Map data;
    List<MovieModel> movie;
    try {
      data = await _tmdbV3.movies.getPouplar();
      movie = MovieModel.fromList(data['results']);
    } catch (e) {
      rethrow;
    }
    return movie;
  }
}
