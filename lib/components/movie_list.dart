import 'package:day12/constants/gaps.dart';
import 'package:day12/constants/sizes.dart';
import 'package:day12/models/movie_detail_model.dart';
import 'package:day12/models/movie_model.dart';
import 'package:day12/screens/detail_screen.dart';
import 'package:day12/services/api_service.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  const MovieList({
    super.key,
    required this.movies,
    required this.width,
    required this.isPoster,
    required this.height,
  });

  final Future<List<MovieModel>> movies;
  final String thumbBaseUrl = "https://image.tmdb.org/t/p/w500";
  final double width;
  final double height;
  final bool isPoster;

  void _onTapped(BuildContext context, int id) {
    late final Future<MovieDetailModel> movieDetail =
        ApiService.getMovieDetailById(id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          movieId: id,
          movieDetail: movieDetail,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: height,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var movie = snapshot.data![index];
                return GestureDetector(
                  onTap: () => _onTapped(context, movie.id),
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          isPoster
                              ? thumbBaseUrl + movie.posterUrl
                              : thumbBaseUrl + movie.backdropUrl,
                          headers: const {
                            'User-Agent':
                                'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36',
                            'Referer': 'https://comic.naver.com',
                          },
                        ),
                      ),
                      if (isPoster)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Gaps.v10,
                            SizedBox(
                              width: width,
                              child: Text(
                                movie.title,
                                style: TextStyle(
                                  fontSize: Sizes.size16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Gaps.h20;
              },
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
