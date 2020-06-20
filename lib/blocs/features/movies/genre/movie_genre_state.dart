import '../../../../models/collections/movie_model.dart';

abstract class MovieGenreState {
  List<MovieModel> movieList;
}

class MovieGenreInitialState extends MovieGenreState {
  @override
  List<MovieModel> movieList = [];
}

class MovieGenreSuccessState extends MovieGenreState {
  @override
  List<MovieModel> movieList = [];
  MovieGenreSuccessState({this.movieList});
}

class MovieGenreErrorState extends MovieGenreState {
  @override
  List<MovieModel> get movieList => [];
}
