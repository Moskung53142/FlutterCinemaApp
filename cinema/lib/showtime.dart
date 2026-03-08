import 'package:cinema/showtimepage/progressappbar.dart';
import 'package:flutter/material.dart';
import 'package:cinema/model/movie_list.dart';
import 'package:cinema/showtimepage/maincontent.dart';

// You can keep this main() for testing this screen directly. 
// It will default to showing movie index 0 (SuperMan).
void main() {
  runApp(
    const MaterialApp(
      title: "Movie Showtime",
      home: ShowtimeScreen(movieIndex: 1), 
    ),
  );
}

// CHANGED: Created a reusable Screen widget that accepts the movieIndex
class ShowtimeScreen extends StatelessWidget {
  final int movieIndex;

  const ShowtimeScreen({
    super.key, 
    required this.movieIndex, // Require the index when navigating here
  });

  @override
  Widget build(BuildContext context) {
    // 1. Get the current movie using the passed index
    final movie = appMovieList[movieIndex];

    return Scaffold(
      body: Stack(
        children: [
          // 2. Make the background image dynamic based on the movie!
          Positioned.fill(
            child: Image.asset(
              movie.moviePic, 
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(148, 92, 92, 92),
              elevation: 0,
              title: ShowtimeAppbar(), // Make sure progressappbar.dart is correct
            ),
            
            // 3. Pass the index down to your maincontent.dart
            body: ShowTimeContent(movieIndex: movieIndex), 
            
          ),
        ],
      ),
    );
  }
}