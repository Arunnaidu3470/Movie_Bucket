import 'package:bloc/bloc.dart';

import 'movie_popular_state.dart';
import 'movie_popular_event.dart';
import '../../../../api/api.dart';
import '../../../../models/models.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MovieState> {
  @override
  MovieState get initialState => MoviePopularInitialState();

  @override
  Stream<MovieState> mapEventToState(MoviePopularEvent event) async* {
    try {
      if (event is MoviePopularFetchEvent) {
        yield MoviePopularFechingState();
        List<MovieModel> movieList = await MovieApi().getPopularMovies();
        yield MoviePopularFeachedState(movieList: movieList);
      }
    } catch (e) {
      yield MoviePopularErrorState(
        'Error while feaching popular movies',
        originalException: e,
      );
    }
  }
}
