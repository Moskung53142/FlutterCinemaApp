import 'package:cinema/model/movie_list.dart';
import 'package:cinema/showtimepage/horizondate.dart';
import 'package:cinema/showtimepage/theatertype.dart';
import 'package:flutter/material.dart';
import 'package:cinema/movie_info.dart';

class ShowTimeContent extends StatefulWidget {
  final int movieIndex; 
  final int userIndex; // NEW: Accept the user index

  // Default to 0 for testing safely
  const ShowTimeContent({super.key, this.movieIndex = 0, this.userIndex = 0});

  @override
  State<ShowTimeContent> createState() => _ShowTimeContentState();
}

class _ShowTimeContentState extends State<ShowTimeContent> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final movie = appMovieList[widget.movieIndex];

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.4),
          Container(
            color: const Color.fromARGB(209, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${movie.category}  |  ${movie.duration} นาที",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "วันที่เข้าฉาย : ${movie.startdate}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.amber,
                          side: const BorderSide(color: Colors.amber, width: 2),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieInfoScreen(
                                movieIndex: widget.movieIndex, 
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "รายละเอียด",
                          style: TextStyle(color: Colors.amber),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: HorizontalDatePicker(
              movieStartDate: movie.startdate, 
              onDateSelected: (newDate) {
                setState(() {
                  selectedDate = newDate;
                });
              },
            ),
          ),
          Container(
            child: Theatertype(
              movie: movie, 
              selectedDate: selectedDate,
              userIndex: widget.userIndex, // NEW: Pass the user index to TheaterType!
            ),
          ),
        ],
      ),
    );
  }
}