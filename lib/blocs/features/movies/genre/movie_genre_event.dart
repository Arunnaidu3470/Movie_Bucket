import '../../../../utils/utils.dart';

abstract class MovieGenreEvent {
  int page = 0;
  Genres genre = Genres.Action;
}

class MovieGetGener extends MovieGenreEvent {
  int page;
  Genres genre;
  MovieGetGener({this.page = 0, this.genre = Genres.Action});
}
