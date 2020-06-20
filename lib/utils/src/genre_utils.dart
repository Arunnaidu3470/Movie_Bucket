enum Genres {
  Action,
  Adventure,
  Animation,
  Comedy,
  Crime,
  Documentary,
  Drama,
  Family,
  Fantasy,
  History,
  Horror,
  Music,
  Mystery,
  Romance,
  ScienceFiction,
  TvMovie,
  Thriller,
  War,
  Western,
}
const Map<Genres, Map> GENRE_INDEX = {
  Genres.Action: {"id": 28, "name": "Action"},
  Genres.Adventure: {"id": 12, "name": "Adventure"},
  Genres.Animation: {"id": 16, "name": "Animation"},
  Genres.Comedy: {"id": 35, "name": "Comedy"},
  Genres.Crime: {"id": 80, "name": "Crime"},
  Genres.Documentary: {"id": 99, "name": "Documentary"},
  Genres.Drama: {"id": 18, "name": "Drama"},
  Genres.Family: {"id": 10751, "name": "Family"},
  Genres.Fantasy: {"id": 14, "name": "Fantasy"},
  Genres.History: {"id": 36, "name": "History"},
  Genres.Horror: {"id": 27, "name": "Horror"},
  Genres.Music: {"id": 10402, "name": "Music"},
  Genres.Mystery: {"id": 9648, "name": "Mystery"},
  Genres.Romance: {"id": 10749, "name": "Romance"},
  Genres.ScienceFiction: {"id": 878, "name": "Science Fiction"},
  Genres.TvMovie: {"id": 10770, "name": "TV Movie"},
  Genres.Thriller: {"id": 53, "name": "Thriller"},
  Genres.War: {"id": 10752, "name": "War"},
  Genres.Western: {"id": 37, "name": "Western"}
};

const List<Map> GENRE_LIST_INDEX = [
  {"id": 28, "name": "Action", "enum": Genres.Action},
  {"id": 12, "name": "Adventure", "enum": Genres.Adventure},
  {"id": 16, "name": "Animation", "enum": Genres.Animation},
  {"id": 35, "name": "Comedy", "enum": Genres.Comedy},
  {"id": 80, "name": "Crime", "enum": Genres.Crime},
  {"id": 99, "name": "Documentary", "enum": Genres.Documentary},
  {"id": 18, "name": "Drama", "enum": Genres.Drama},
  {"id": 10751, "name": "Family", "enum": Genres.Family},
  {"id": 14, "name": "Fantasy", "enum": Genres.Fantasy},
  {"id": 36, "name": "History", "enum": Genres.History},
  {"id": 27, "name": "Horror", "enum": Genres.Horror},
  {"id": 10402, "name": "Music", "enum": Genres.Music},
  {"id": 9648, "name": "Mystery", "enum": Genres.Mystery},
  {"id": 10749, "name": "Romance", "enum": Genres.Romance},
  {"id": 878, "name": "Science Fiction", "enum": Genres.ScienceFiction},
  {"id": 10770, "name": "TV Movie", "enum": Genres.TvMovie},
  {"id": 53, "name": "Thriller", "enum": Genres.Thriller},
  {"id": 10752, "name": "War", "enum": Genres.War},
  {"id": 37, "name": "Western", "enum": Genres.Western},
];

const Map<int, Genres> _GENRE_ID_INDEX = {
  28: Genres.Action,
  12: Genres.Adventure,
  16: Genres.Animation,
  35: Genres.Comedy,
  80: Genres.Crime,
  99: Genres.Documentary,
  18: Genres.Drama,
  10751: Genres.Family,
  14: Genres.Fantasy,
  36: Genres.History,
  27: Genres.Horror,
  10402: Genres.Music,
  9648: Genres.Mystery,
  10749: Genres.Romance,
  878: Genres.ScienceFiction,
  10770: Genres.TvMovie,
  53: Genres.Thriller,
  10752: Genres.War,
  37: Genres.Western,
};

List<String> get allGenreNames =>
    GENRE_LIST_INDEX.map<String>((e) => e['name']).toList();

List<int> get allGenreIs => GENRE_LIST_INDEX.map<int>((e) => e['id']).toList();

int getGenreIdByGenre(Genres genre) => GENRE_INDEX[genre]['id'];

String getGenreNameByGenre(Genres genre) => GENRE_INDEX[genre]['name'];

Genres getGenreById(int genreId) {
  if (!_GENRE_ID_INDEX.containsKey(genreId)) return null;
  return _GENRE_ID_INDEX[genreId];
}

List<Genres> get allGenreEnums => Genres.values;
