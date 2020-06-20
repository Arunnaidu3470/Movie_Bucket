import 'package:movie_bucket/errors/errors.dart';

class MoviePopularException extends BaseException {
  final String message;
  final String description;
  final Object originalException;
  MoviePopularException(
    this.message, {
    this.description,
    this.originalException,
  }) : super(message);
}
