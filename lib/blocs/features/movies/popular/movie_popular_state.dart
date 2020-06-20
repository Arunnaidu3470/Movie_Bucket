import '../../../../models/models.dart';
import '../../../../errors/errors.dart';
import '../../../../app/ui/widgets/state_handler_widget.dart';

abstract class MovieState extends StateHandlerWidgetState {
  List<MovieModel> movieList = [];
  BaseException error;
  @override
  StatehandlerStates get state => StatehandlerStates.initialState;
}

class MoviePopularInitialState extends MovieState {
  @override
  List<MovieModel> movieList = [];
  @override
  StatehandlerStates get state => StatehandlerStates.initialState;
}

class MoviePopularFeachedState extends MovieState {
  @override
  final List<MovieModel> movieList;
  @override
  StatehandlerStates get state => StatehandlerStates.loadedState;

  MoviePopularFeachedState({this.movieList});
}

class MoviePopularFechingState extends MovieState {
  @override
  List<MovieModel> movieList = [];
  @override
  StatehandlerStates get state => StatehandlerStates.loadingState;
}

class MoviePopularErrorState extends MovieState
    implements MoviePopularException {
  final String message;
  final String description;
  final Object originalException;
  @override
  List<MovieModel> get movieList => [];
  @override
  BaseException get error => this;
  @override
  StatehandlerStates get state => StatehandlerStates.errorState;

  MoviePopularErrorState(
    this.message, {
    this.description,
    this.originalException,
  });
}
