import 'package:cinema/model/movie_list.dart';

class Theater {
  final int theaterNo;
  final String status;
  final String movie;
  final String type;
  final String theaterName;

  Theater({
    required this.theaterNo,
    required this.status,
    required this.movie,
    required this.type,
    required this.theaterName,
  });
}

final List<Theater> thearterList = [
  Theater(
    theaterNo: 1,
    status: "ไม่ว่าง",
    movie: appMovieList[0].title,
    type: "IMAX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวอังคาร",
  ),
  Theater(
    theaterNo: 2,
    status: "ไม่ว่าง",
    movie: appMovieList[0].title,
    type: "IMAX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวอังคาร",
  ),
  Theater(
    theaterNo: 3,
    status: "ไม่ว่าง",
    movie: appMovieList[0].title,
    type: "4DX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวอังคาร",
  ),
  Theater(
    theaterNo: 4,
    status: "ไม่ว่าง",
    movie: appMovieList[0].title,
    type: "Kids",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวอังคาร",
  ),
  Theater(
    theaterNo: 1,
    status: "ไม่ว่าง",
    movie: appMovieList[0].title,
    type: "4DX",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวพุธ",
  ),
  Theater(
    theaterNo: 2,
    status: "ไม่ว่าง",
    movie: appMovieList[0].title,
    type: "Kids",
    theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวพุธ",
  ),
];
