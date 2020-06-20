export 'blocs_error/movie_popular_error.dart';

class BaseException implements Exception {
  final String message;
  final String description;
  final Object originalException;

  const BaseException(this.message, {this.description, this.originalException});
}
