import 'package:cinema/model/movie_list.dart';
import 'package:cinema/showtimepage/horizondate.dart';
import 'package:cinema/showtimepage/theatertype.dart';
import 'package:flutter/material.dart';

class ShowTimeContent extends StatelessWidget {
  const ShowTimeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appMovieList[0].title,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${appMovieList[0].category}  |  ${appMovieList[0].duration} นาที",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "วันที่เข้าฉาย : ${appMovieList[0].startdate}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.amber,
                          side: BorderSide(color: Colors.amber, width: 2),
                        ),
                        onPressed: (){},
                        child: Text(
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
              movieStartDate: appMovieList[0].startdate,
            ),
          ),
          Container(child: Theatertype(movie: appMovieList[0])),
        ],
      ),
    );
  }
}
