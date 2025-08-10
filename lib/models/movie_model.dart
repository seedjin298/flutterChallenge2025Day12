class MovieModel {
  final String title, backdropUrl, posterUrl;
  final int id;

  MovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        backdropUrl = json['backdrop_path'],
        posterUrl = json['poster_path'],
        id = json['id'];
}
