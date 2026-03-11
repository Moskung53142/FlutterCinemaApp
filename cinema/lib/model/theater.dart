import 'package:cinema/model/movie_list.dart';

class Theater {
  final int theaterNo;
  final String status;
  final String movie;
  final String type;
  final String theaterName;
  final double distance; 

  Theater({
    required this.theaterNo,
    required this.status,
    required this.movie,
    required this.type,
    required this.theaterName,
    required this.distance,
  });
}

final List<Theater> thearterList = [

//ฉายทุกเรื่อง
  for (int i = 0; i < appMovieList.length; i++)
    Theater(
      theaterNo: i + 1,
      status: "ไม่ว่าง",
      movie: appMovieList[i].title,
      type: (i % 3 == 0) ? "IMAX" : (i % 3 == 1) ? "4DX" : "Kids",
      theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวอังคาร",
      distance: 3.1,
    ),

//ฉายทุกเรื่อง
  for (int i = 0; i < appMovieList.length; i++)
    Theater(
      theaterNo: i + 1,
      status: "ไม่ว่าง",
      movie: appMovieList[i].title,
      type: (i % 2 == 0) ? "IMAX" : "4DX",
      theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา วงแหวนดาวพฤหัสบดี",
      distance: 7.8,
    ),

  Theater(
    theaterNo: 1,
    status: "ไม่ว่าง",
    movie: appMovieList[0].title,
    type: "IMAX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวพุธ",
    distance: 12.5,
  ),
  Theater(
    theaterNo: 2,
    status: "ไม่ว่าง",
    movie: appMovieList[2].title,
    type: "IMAX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวพุธ",
    distance: 12.5,
  ),
  Theater(
    theaterNo: 3,
    status: "ไม่ว่าง",
    movie: appMovieList[4].title,
    type: "IMAX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวพุธ",
    distance: 12.5,
  ),
  Theater(
    theaterNo: 4,
    status: "ไม่ว่าง",
    movie: appMovieList[6].title,
    type: "IMAX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวพุธ",
    distance: 12.5,
  ),
  Theater(
    theaterNo: 5,
    status: "ไม่ว่าง",
    movie: appMovieList[8].title,
    type: "IMAX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวพุธ",
    distance: 12.5,
  ),

 
  Theater(
    theaterNo: 1,
    status: "ไม่ว่าง",
    movie: appMovieList[1].title,
    type: "IMAX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวพลูโต",
    distance: 18.4,
  ),
  Theater(
    theaterNo: 2,
    status: "ไม่ว่าง",
    movie: appMovieList[3].title,
    type: "4DX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวพลูโต",
    distance: 18.4,
  ),
  Theater(
    theaterNo: 3,
    status: "ไม่ว่าง",
    movie: appMovieList[5].title,
    type: "IMAX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวพลูโต",
    distance: 18.4,
  ),
  Theater(
    theaterNo: 4,
    status: "ไม่ว่าง",
    movie: appMovieList[7].title,
    type: "IMAX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวพลูโต",
    distance: 18.4,
  ),
  Theater(
    theaterNo: 5,
    status: "ไม่ว่าง",
    movie: appMovieList[9].title,
    type: "IMAX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวพลูโต",
    distance: 18.4,
  ),

  Theater(
    theaterNo: 1,
    status: "ไม่ว่าง",
    movie: appMovieList[10].title,
    type: "IMAX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวเนปจูน",
    distance: 21.6,
  ),
  Theater(
    theaterNo: 2,
    status: "ไม่ว่าง",
    movie: appMovieList[11].title,
    type: "4DX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวเนปจูน",
    distance: 21.6,
  ),
  Theater(
    theaterNo: 3,
    status: "ไม่ว่าง",
    movie: appMovieList[12].title,
    type: "Kids",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวเนปจูน",
    distance: 21.6,
  ),
  Theater(
    theaterNo: 4,
    status: "ไม่ว่าง",
    movie: appMovieList[13].title,
    type: "IMAX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวเนปจูน",
    distance: 21.6,
  ),
  Theater(
    theaterNo: 5,
    status: "ไม่ว่าง",
    movie: appMovieList[14].title,
    type: "4DX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวเนปจูน",
    distance: 21.6,
  ),

  Theater(
    theaterNo: 1,
    status: "ไม่ว่าง",
    movie: appMovieList[15].title,
    type: "IMAX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวลูกไก่",
    distance: 15.3,
  ),
  Theater(
    theaterNo: 2,
    status: "ไม่ว่าง",
    movie: appMovieList[0].title,
    type: "IMAX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวลูกไก่",
    distance: 15.3,
  ),
  Theater(
    theaterNo: 3,
    status: "ไม่ว่าง",
    movie: appMovieList[5].title,
    type: "4DX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวลูกไก่",
    distance: 15.3,
  ),
  Theater(
    theaterNo: 4,
    status: "ไม่ว่าง",
    movie: appMovieList[7].title,
    type: "IMAX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวลูกไก่",
    distance: 15.3,
  ),
  Theater(
    theaterNo: 5,
    status: "ไม่ว่าง",
    movie: appMovieList[9].title,
    type: "Kids",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวลูกไก่",
    distance: 15.3,
  ),
];