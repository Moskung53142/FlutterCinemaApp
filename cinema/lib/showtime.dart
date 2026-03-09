import 'package:cinema/showtimepage/progressappbar.dart';
import 'package:flutter/material.dart';
import 'package:cinema/model/movie_list.dart';
import 'package:cinema/showtimepage/maincontent.dart';

// You can keep this main() for testing this screen directly.
void main() {
  runApp(
    const MaterialApp(
      title: "Movie Showtime",
      // Set default movieIndex to 0 and userIndex to 0 for testing
      home: ShowtimeScreen(movieIndex: 0, userIndex: 2),
    ),
  );
}

class ShowtimeScreen extends StatelessWidget {
  final int movieIndex;
  final int userIndex; // NEW: Require the user index

  const ShowtimeScreen({
    super.key,
    required this.movieIndex,
    required this.userIndex, // NEW
  });

  @override
  Widget build(BuildContext context) {
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
