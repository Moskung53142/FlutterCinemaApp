import 'package:cinema/showtimepage/progressappbar.dart';
import 'package:flutter/material.dart';
import 'package:cinema/model/movie_list.dart';
import 'package:cinema/showtimepage/maincontent.dart';

class ShowtimeScreen extends StatelessWidget {
  const ShowtimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    final int movieIndex = args?['movieIndex'] ?? 1;
    final int userIndex = args?['userIndex'] ?? 2;
    final movie = appMovieList[movieIndex];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(movie.moviePic, fit: BoxFit.cover),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(148, 92, 92, 92),
              elevation: 0,
              title: const ShowtimeAppbar(),
            ),

            // NEW: Pass BOTH the movie index and user index down!
            body: ShowTimeContent(movieIndex: movieIndex, userIndex: userIndex),
          ),
        ],
      ),
    );
  }
}
