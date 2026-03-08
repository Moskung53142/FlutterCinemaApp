import 'package:cinema/showtimepage/progressappbar.dart';
import 'package:flutter/material.dart';
import 'package:cinema/model/movie_list.dart';
import 'package:cinema/showtimepage/maincontent.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Movie Showtime",
      home: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              appMovieList[0].moviePic,
              fit: BoxFit.cover,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(148, 92, 92, 92),
              elevation: 0,
              title: ShowtimeAppbar(),
            ),
            body: const ShowTimeContent(),
            
            
          ),
        ],
      ),
    ),
  );
}


