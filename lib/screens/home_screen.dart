import 'package:day12/components/movie_list.dart';
import 'package:day12/components/section_title.dart';
import 'package:day12/constants/gaps.dart';
import 'package:day12/constants/sizes.dart';
import 'package:day12/models/movie_model.dart';
import 'package:day12/services/api_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> popularMovies = ApiService.getPopularMovies();
  final Future<List<MovieModel>> nowPlayingMovies =
      ApiService.getNowPlayingMovies();
  final Future<List<MovieModel>> comingSoonMovies =
      ApiService.getComingSoonMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size16,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Gaps.v40,
                SectionTitle(
                  title: "Popular Movies",
                ),
                Gaps.v20,
                MovieList(
                  movies: popularMovies,
                  width: 300,
                  height: 170,
                  isPoster: false,
                ),
                Gaps.v20,
                SectionTitle(
                  title: "Now in Cinemas",
                ),
                Gaps.v20,
                MovieList(
                  movies: nowPlayingMovies,
                  width: 150,
                  height: 350,
                  isPoster: true,
                ),
                SectionTitle(
                  title: "Coming Soon",
                ),
                Gaps.v20,
                MovieList(
                  movies: nowPlayingMovies,
                  width: 150,
                  height: 350,
                  isPoster: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
