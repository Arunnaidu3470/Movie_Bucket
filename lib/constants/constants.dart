class MovieConstants {
  static const String MOVIE_TITLE = 'title';
  static const String MOVIE_PLOT = 'overview';
  static const String MOVIE_POSTER = 'poster_path';
  static const String MOVIE_RATING = 'vote_average';
  static const String MOVIE_BACK_DROP_POSTER = 'backdrop_path';
  static const String MOVIE_RELEASE_DATE = 'release_date';
  static const String MOVIE_ID = 'id';
  static const String Movie_GENERS = 'genres';
}

class CastConstants {
  static const String Cast_ID = 'cast_id';
  static const String NAME = 'name';
  static const String CHARACTER_NAME = 'character';
  static const String CREDIT_ID = 'credit_id';
  static const String GENDER = 'gender';
  static const String ACTOR_ID = 'id';
  static const String ORDER = 'order';
  static const String PROFILE_PATH = 'profile_path';
}

class SimilarMovieConstants {
  static const String MOVIE_ID = 'id';
  static const String MOVIE_TITLE = 'title';
  static const String ORGINAL_LANGUAGE = 'original_language';
  static const String MOVIE_PLOT = 'overview';
  static const String MOVIE_RATING = 'vote_average';
  static const String MOVIE_BACK_DROP_POSTER = 'backdrop_path';
  static const String MOVIE_POSTER = 'poster_path';
  static const String MOVIE_RELEASE_DATE = 'release_date';
}

class PeopleConstant {
  static const String PEOPLE_ID = 'id';
  static const String IMDB_ID = 'imdb_id';
  static const String NAME = 'name';
  static const String GENDER = 'gender';
  static const String KNOWN_FOR_DEPARTMENT = 'known_for_department';
  static const String BIOGRAPHY = 'biography';
  static const String PLACE_OF_BIRTH = 'place_of_birth';
  static const String BIRTHDAY = 'birthday';
  static const String DEATH_DAY = 'deathday';
  static const String POPULARITY = 'popularity';
  static const String PROFILE_PATH = 'profile_path';
  static const String ADULT = 'adult';
  static const String HOMEPAGE = 'homepage';
}

//-----------------------------------TV-SHOW----------------------------------------

class TVShowConstants {
  ///poster path in String
  static const String POSTER_PATH = 'poster_path';

  ///Popularity of the TV show in double
  static const String POPULARITY = 'popularity';

  ///TMDB id of the TV Show in String
  static const String ID = 'id';

  ///backdrop path for the TV show in String
  static const String BACK_DROP = 'backdrop_path';

  ///average user rating in double
  static const String RATING = 'vote_average';

  ///Story line of the Tv show in String
  static const String OVERVIEW = 'overview';

  ///released date in String
  static const String AIR_DATE = 'first_air_date';

  ///origian country in String
  static const String ORIGIAN_COUNTRY = 'origin_country';

  ///gener in List of int
  static const String GENRE_IDS = 'genre_ids';

  ///original movie language in String
  static const String ORGINAL_LANGUAGE = 'orginal_language';

  ///Votes given by user of TMDB in int
  static const String VOTE_COUNT = 'vote_count';

  ///Name of the move after translation in String
  static const String TITLE = 'name';

  ///Name of the movie in orginal language without translation in String
  static const String ORGINAL_TITLE = 'orginal_name';
}

class ProductionConstant {
  static const String ID = 'id';
  static const String LOGO_PATH = 'logo_path';
  static const String NAME = 'name';
  static const String ORIGIN_COUNTRY = 'origin_country';
}
