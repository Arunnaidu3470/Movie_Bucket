import 'package:flutter/foundation.dart';

class ImageServices {
  static const String BASE_URL = 'https://image.tmdb.org/t/p';

  //Poster Sizes
  static const String POSTER_SIZE_LOWEST = "/w92";
  static const String POSTER_SIZE_LOW = "/w154";
  static const String POSTER_SIZE_MEDIUM = "/w185";
  static const String POSTER_SIZE_MEDIUMPLUS = "/w342";
  static const String POSTER_SIZE_HIGH = "/w500";
  static const String POSTER_SIZE_HIGHEST = "/w780";
  static const String POSTER_SIZE_ORIGINAL = "/original";

  //Logo Sizes
  static const String LOGO_SIZE_LOWEST = "/w45";
  static const String LOGO_SIZE_LOW = "/w92";
  static const String LOGO_SIZE_MEDIUM = "/w154";
  static const String LOGO_SIZE_MEDIUMPLUS = "/w185";
  static const String LOGO_SIZE_HIGH = "/w300";
  static const String LOGO_SIZE_HIGHEST = "/w500";
  static const String LOGO_SIZE_ORIGINAL = "/original";

  //Backdrop Size
  static const String BACKDROP_SIZE_LOWEST = "/w300";
  static const String BACKDROP_SIZE_MEDIUM = "/w185";
  static const String BACKDROP_SIZE_HIGHEST = "/w780";
  static const String BACKDROP_SIZE_QRIGINAL = "/original";

  //profile size
  static const String PROFILE_SIZE_LOWEST = "/w45";
  static const String PROFILE_SIZE_MEDIUM = "/w185";
  static const String PROFILE_SIZE_HIGHEST = "/w632";
  static const String PROFILE_SIZE_QRIGINAL = "/original";

  //still size
  static const String STILL_SIZE_LOWEST = "/w92";
  static const String STILL_SIZE_MEDIUM = "/w185";
  static const String STILL_SIZE_HIGHEST = "/w300";
  static const String STILL_SIZE_QRIGINAL = "/original";

  static String getImageUrlOf(String path, {@required String size}) {
    ///Returns a Poster's URL with a defalult size of medium
    ///size can take values from [ImageServices] class
    ///You can get urls of logo,image,backdrop,profile,still
    return '$BASE_URL$size$path';
  }
}
