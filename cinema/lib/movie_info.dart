import "package:flutter/material.dart";
import 'package:cinema/model/movie_list.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Movie_Info",
      home: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(appMovieList[0].moviePic, fit: BoxFit.cover),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const BackButton(),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  color: const Color.fromARGB(235, 0, 0, 0),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appMovieList[0].title,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${appMovieList[0].category} | ${appMovieList[0].duration} นาที",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "วันที่เข้าฉาย  : ${appMovieList[0].startdate}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.black,
                  width: double.infinity,
                  height: 350,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        "เรื่องย่อ",
                        style: TextStyle(color: Colors.white, fontSize: 21),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        appMovieList[1].description,
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height:0,)
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton: Container(
              width: 80,
              height: 40,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: TextButton(
                  onPressed: null,
                  child: Text(
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
    ),
  );
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilledButton(
          onPressed: null,
          child: Image.asset(
            'asset/image/Vector.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
