import 'package:cinema/model/movie_list.dart';
import 'package:cinema/model/theater.dart';
import 'package:cinema/model/user.dart';
import 'package:cinema/showtimepage/horizondate.dart';
import 'package:cinema/seatselect.dart';
import 'package:cinema/movie_info.dart';
import 'package:cinema/showtimepage/topbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Cinemadetail(
        theaterName: "เวสเกต ซีนีเพล็กซ์ สาขา ดาวอังคาร",
        userIndex: 0,
      ),
    ),
  );
}

class Cinemadetail extends StatefulWidget {
  final String theaterName;
  final int userIndex;

  const Cinemadetail({
    super.key,
    required this.theaterName,
    required this.userIndex,
  });

  @override
  State<Cinemadetail> createState() => _CinemadetailState();
}

class _CinemadetailState extends State<Cinemadetail> {
  DateTime selectedDate = DateTime.now();

  // Generate showtimes based on movie duration starting 08:00
  List<DateTime> _getShowtimes(int durationMinutes) {
    List<DateTime> times = [];
    DateTime base = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      8,
      0,
    );
    DateTime limit = base.add(const Duration(hours: 16));

    while (base.isBefore(limit)) {
      times.add(base);
      base = base.add(Duration(minutes: durationMinutes));
    }
    return times;
  }

  @override
  Widget build(BuildContext context) {
    // Get only theaters that belong to this cinema
    final List<Theater> screens = thearterList
        .where((t) => t.theaterName == widget.theaterName)
        .toList();

    final DateTime now = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── TOP NAV BAR ──────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TopBar(selectedIndex: -1),
            ),

            // ── THEATER NAME ─────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: Color.fromARGB(255, 255, 255, 255),
                    size: 26,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      widget.theaterName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── DATE PICKER ──────────────────────────────
            HorizontalDatePicker(
              movieStartDate: appMovieList.first.startdate,
              onDateSelected: (date) {
                setState(() => selectedDate = date);
              },
            ),

            // ── SCREEN LIST ──────────────────────────────
            Expanded(
              child: ListView.separated(
                itemCount: screens.length,
                separatorBuilder: (_, __) => const Divider(
                  color: Color.fromARGB(123, 88, 88, 88),
                  thickness: 1,
                ),
                itemBuilder: (context, index) {
                  final Theater theater = screens[index];

                  // ✅ แก้ไข: ค้นหาจาก appMovieList ทั้งหมด ไม่ใช่แค่ now_showing
                  final movielist movie = appMovieList.firstWhere(
                    (m) => m.title == theater.movie,
                    orElse: () => appMovieList.first,
                  );
                  final int movieIndex = appMovieList.indexOf(movie);

                  final List<DateTime> showtimes = _getShowtimes(
                    movie.duration,
                  );

                  // Highlight next upcoming showtime
                  DateTime? nextTime;
                  try {
                    nextTime = showtimes.firstWhere((t) => t.isAfter(now));
                  } catch (_) {}

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Poster
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                movie.moviePic,
                                width: 100,
                                height: 148,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${movie.category} | ${movie.duration} นาที",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "วันเริ่มฉาย : ${movie.startdate}",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: const Color(0xFFF0B90B),
                                      side: const BorderSide(
                                        color: Color(0xFFF0B90B),
                                        width: 1,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 0,
                                      ),
                                      minimumSize: const Size(0, 30),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => MovieInfoScreen(
                                            movieIndex: movieIndex,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "รายละเอียด",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),

                        // ── Theatre number ──
                        Text(
                          "Theatre ${theater.theaterNo}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // ── Showtime buttons ──
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: showtimes.map((time) {
                            final bool isPast = time.isBefore(now);
                            final bool isNext = time == nextTime;
                            final String timeStr =
                                "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

                            return OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: isNext
                                    ? const Color(0xFFF0B90B)
                                    : Colors.white,
                                disabledForegroundColor: Colors.white24,
                                side: BorderSide(
                                  color: isPast
                                      ? Colors.white24
                                      : isNext
                                          ? const Color(0xFFF0B90B)
                                          : Colors.white54,
                                  width: 1.5,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: isPast
                                  ? null
                                  : () {
                                      final currentUser =
                                          appUser[widget.userIndex];

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => Seatselected(
                                            bookingData: {
                                              'user_index': widget.userIndex,
                                              'user_name':
                                                  "${currentUser.name} ${currentUser.surname}",
                                              'user_email': currentUser.email,
                                              'movie_index': movieIndex,
                                              'theaterName': widget.theaterName,
                                              'movie_title': movie.title,
                                              'date':
                                                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                              'cinema': widget.theaterName,
                                              'screen': theater.theaterNo,
                                              'time': timeStr,
                                            },
                                          ),
                                        ),
                                      );
                                    },
                              child: Text(
                                timeStr,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 8),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
