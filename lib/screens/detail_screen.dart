import 'package:day12/constants/gaps.dart';
import 'package:day12/constants/sizes.dart';
import 'package:day12/models/movie_detail_model.dart';
import 'package:day12/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.movieId,
    required this.movieDetail,
    required this.posterUrl,
  });

  final int movieId;

  final String posterUrl;

  final Future<MovieDetailModel> movieDetail;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final String thumbBaseUrl = "https://image.tmdb.org/t/p/w500";
  late Future<MovieDetailModel> movie;

  @override
  void initState() {
    super.initState();
    movie = ApiService.getMovieDetailById(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.movieId,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(thumbBaseUrl + widget.posterUrl),
            fit: BoxFit.cover,
            opacity: 1,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            titleSpacing: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: FaIcon(
                FontAwesomeIcons.angleLeft,
                size: Sizes.size28,
              ),
            ),
            title: Text(
              'Back to list',
              style: TextStyle(
                fontSize: Sizes.size20 + Sizes.size1,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          body: FutureBuilder(
            future: widget.movieDetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var movie = snapshot.data!;
                List totalGenres = [];
                for (var genre in movie.genres) {
                  totalGenres.add(genre['name']);
                }
                return SizedBox(
                  width: double.infinity,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        // left: Sizes.size20,
                        // right: Sizes.size60,
                        // bottom: Sizes.size32,
                        horizontal: Sizes.size20,
                        vertical: Sizes.size32,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 20,
                                  fit: FlexFit.tight,
                                  child: SizedBox(),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    right: Sizes.size40,
                                  ),
                                  child: Text(
                                    movie.title,
                                    style: TextStyle(
                                      height: 1,
                                      color: Colors.white,
                                      fontSize: Sizes.size40,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: SizedBox(),
                                ),
                                Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.solidStar,
                                      color: (movie.vote / 10) >= 0.2
                                          ? Colors.amberAccent
                                          : const Color.fromARGB(
                                              177, 153, 145, 145),
                                      size: Sizes.size20,
                                    ),
                                    Gaps.h8,
                                    FaIcon(
                                      FontAwesomeIcons.solidStar,
                                      color: (movie.vote / 10) >= 0.4
                                          ? Colors.amberAccent
                                          : const Color.fromARGB(
                                              177, 153, 145, 145),
                                      size: Sizes.size20,
                                    ),
                                    Gaps.h8,
                                    FaIcon(
                                      FontAwesomeIcons.solidStar,
                                      color: (movie.vote / 10) >= 0.6
                                          ? Colors.amberAccent
                                          : const Color.fromARGB(
                                              177, 153, 145, 145),
                                      size: Sizes.size20,
                                    ),
                                    Gaps.h8,
                                    FaIcon(
                                      FontAwesomeIcons.solidStar,
                                      color: (movie.vote / 10) >= 0.8
                                          ? Colors.amberAccent
                                          : const Color.fromARGB(
                                              177, 153, 145, 145),
                                      size: Sizes.size20,
                                    ),
                                    Gaps.h8,
                                    FaIcon(
                                      FontAwesomeIcons.solidStar,
                                      color: (movie.vote / 10) == 1
                                          ? Colors.amberAccent
                                          : const Color.fromARGB(
                                              177, 153, 145, 145),
                                      size: Sizes.size20,
                                    ),
                                  ],
                                ),
                                Flexible(
                                  flex: 2,
                                  fit: FlexFit.tight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                                Text(
                                  totalGenres.join(', '),
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Flexible(
                                  flex: 4,
                                  fit: FlexFit.tight,
                                  child: SizedBox(),
                                ),
                                Text(
                                  "Storyline",
                                  style: TextStyle(
                                    fontSize: Sizes.size32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    right: Sizes.size40,
                                  ),
                                  child: Text(
                                    movie.overview,
                                    maxLines: 7,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      height: 1.3,
                                      color: Colors.white,
                                      fontSize: Sizes.size16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 6,
                                  fit: FlexFit.tight,
                                  child: SizedBox(),
                                ),
                              ],
                            ),
                          ),
                          UnconstrainedBox(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                horizontal: Sizes.size96,
                                vertical: Sizes.size20,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amberAccent,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                "Buy ticket",
                                style: TextStyle(
                                  fontSize: Sizes.size16 + Sizes.size2,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
