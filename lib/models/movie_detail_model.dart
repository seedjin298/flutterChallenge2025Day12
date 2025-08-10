class MovieDetailModel {
  final String title, overview, posterUrl;
  final double vote;
  final List<dynamic> genres;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        overview = json['overview'],
        posterUrl = json['poster_path'],
        vote = json['vote_average'],
        genres = json['genres'];
}
