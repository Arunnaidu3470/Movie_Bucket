class MovieModel {
  final String posterPath;
  final bool isAdult;
  final String overview;
  final String releaseDate;
  final List<Genre> generId;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final String backDropPath;
  final double popularity;
  final int voteCount;
  final double voteAverage;
  final bool video;

  const MovieModel({
    this.posterPath,
    this.isAdult,
    this.overview,
    this.releaseDate,
    this.generId,
    this.id,
    this.originalTitle,
    this.originalLanguage,
    this.title,
    this.backDropPath,
    this.popularity,
    this.voteCount,
    this.voteAverage,
    this.video,
  });

  factory MovieModel.fromMap(Map movieData) {
    if (movieData == null) return null;
    return MovieModel(
      posterPath: movieData['poster_path'],
      isAdult: movieData['adult'],
      overview: movieData['overview'],
      releaseDate: movieData['release_date'],
      generId: Genre.fromMap(movieData['genre_ids']),
      id: movieData['id'],
      originalTitle: movieData['orginal_title'],
      originalLanguage: movieData['original_language'],
      title: movieData['title'],
      backDropPath: movieData['backdrop_path'],
      popularity: movieData['popularity'],
      voteCount: movieData['vote_count'],
      video: movieData['video'],
      voteAverage: double.parse('${movieData['vote_average']}' ?? '0'),
    );
  }

  static List<MovieModel> fromList(List movieList) {
    return movieList
        .map<MovieModel>((movie) => MovieModel.fromMap(movie))
        .toList();
  }
}

class Genre {
  final int id;
  final String name;
  Genre({this.id, this.name});

  static List<Genre> fromMap(List genreIdList) {
    return genreIdList
        .map<Genre>((genreId) => Genre(
              id: genreId,
              name: getGenreById(genreId),
            ))
        .toList();
  }
}

String getGenreById(int id) {
  final Map<int, String> _genresMap = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentry',
    18: 'Drama',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Science Fiction',
    10770: 'TV Movie',
    53: 'Thriller',
    10752: 'War',
    37: 'Western',
  };
  return _genresMap[id];
}
