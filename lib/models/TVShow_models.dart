class MovieRecommendations {
  final String posterPath;
  final double popularity;
  final int movieId;
  final String backDropPath;
  final double voteAverage;
  final String overview;
  final String firstAirDate;
  final List<String> originCountry;
  final List<int> generIds;
  final String orginalLanguage;
  final int voteCount;
  final String name;
  final String orginalName;
  MovieRecommendations(
      {this.posterPath,
      this.popularity,
      this.movieId,
      this.backDropPath,
      this.voteAverage,
      this.overview,
      this.firstAirDate,
      this.originCountry,
      this.generIds,
      this.orginalLanguage,
      this.voteCount,
      this.name,
      this.orginalName});

  factory MovieRecommendations.getD() {
    return MovieRecommendations();
  }

  factory MovieRecommendations.getData(Map<String, dynamic> data) {
    return MovieRecommendations();
  }
}

class Temp {
  final int results;
  final int currentPage;
  final List<MovieRecommendations> list;
  Temp({
    this.results,
    this.currentPage,
    this.list,
  });

  factory Temp.getData(Map<String,dynamic> data) {
    return Temp(
      results: 1,
      currentPage: 1,
      list: data['results'],
    );
  }
}
