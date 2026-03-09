import "package:flutter/material.dart";
import 'package:cinema/model/movie_list.dart';

// CHANGED: Converted from void main() into a reusable Screen Widget
class MovieInfoScreen extends StatelessWidget {
  final int movieIndex; // NEW: Receives the index passed from the previous screen

  const MovieInfoScreen({super.key, required this.movieIndex});

  @override
  Widget build(BuildContext context) {
    // Look up the specific movie using the passed index
    final movie = appMovieList[movieIndex];

    return Scaffold(
      backgroundColor: Colors.black, // Fallback background
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(movie.moviePic, fit: BoxFit.cover),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              // Use our custom back button below
              leading: const MovieInfoBackButton(),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  color: const Color.fromARGB(235, 0, 0, 0),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${movie.category} | ${movie.duration} นาที",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "วันที่เข้าฉาย  : ${movie.startdate}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: 350,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "เรื่องย่อ",
                        style: TextStyle(color: Colors.white, fontSize: 21),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        movie.description,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 0)
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: Container(
              width: 80,
              height: 40,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: TextButton(
                  // CHANGED: Navigate back to the Showtime screen
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "จองเลย",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Back Button
class MovieInfoBackButton extends StatelessWidget {
  const MovieInfoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      // CHANGED: Navigate back when the Vector arrow is clicked
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Image.asset(
        'asset/image/Vector.png',
        width: 24,
        height: 24,
        fit: BoxFit.contain,
      ),
    );
  }
}