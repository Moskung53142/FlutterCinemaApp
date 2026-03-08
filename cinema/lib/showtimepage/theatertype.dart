import 'package:flutter/material.dart';
import 'package:cinema/model/movie_list.dart';
import 'package:cinema/model/theater.dart';

class Theatertype extends StatefulWidget {
  final movielist movie;
  final DateTime selectedDate; // NEW: Requires the selected date from parent

  const Theatertype({
    super.key,
    required this.movie,
    required this.selectedDate,
  });

  @override
  State<Theatertype> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Theatertype> {
  int selectedIndex = 0;
  final List<String> types = ["ทั้งหมด", "IMAX", "4DX", "Kids"];

  List<DateTime> getShowtimes(int durationMinutes) {
    List<DateTime> times = [];
    DateTime now = DateTime.now();
    DateTime currentTime = DateTime(now.year, now.month, now.day, 8, 0);
    DateTime endTimeLimit = DateTime(now.year, now.month, now.day + 1, 0, 0);

    while (currentTime.isBefore(endTimeLimit)) {
      times.add(currentTime);
      currentTime = currentTime.add(Duration(minutes: durationMinutes));
    }
    return times;
  }

  @override
  Widget build(BuildContext context) {
    String selectedType = types[selectedIndex];
    Map<String, List<Theater>> groupedTheaters = {};

    for (var theater in thearterList) {
      if (theater.movie == widget.movie.title) {
        if (selectedType == "ทั้งหมด" || theater.type == selectedType) {
          if (!groupedTheaters.containsKey(theater.theaterName)) {
            groupedTheaters[theater.theaterName] = [];
          }
          groupedTheaters[theater.theaterName]!.add(theater);
        }
      }
    }

    // 1. Get base times
    List<DateTime> baseShowtimes = getShowtimes(widget.movie.duration);

    // 2. NEW: Upgrade times to use the EXACT date the user clicked on
    List<DateTime> actualShowtimes = baseShowtimes
        .map(
          (time) => DateTime(
            widget.selectedDate.year,
            widget.selectedDate.month,
            widget.selectedDate.day,
            time.hour,
            time.minute,
          ),
        )
        .toList();

    DateTime now = DateTime.now();
    DateTime? nextUpcomingTime;
    try {
      nextUpcomingTime = actualShowtimes.firstWhere(
        (time) => time.isAfter(now),
      );
    } catch (e) {
      nextUpcomingTime = null;
    }

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(types.length, (index) {
                bool isSelected = selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: isSelected
                          ? const Color(0xFFF0B90B)
                          : Colors.transparent,
                      foregroundColor: isSelected ? Colors.black : Colors.white,
                      side: isSelected
                          ? null
                          : const BorderSide(color: Colors.white54, width: 1.0),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Text(
                      types[index],
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 25),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: groupedTheaters.length,
            itemBuilder: (context, index) {
              String cinemaName = groupedTheaters.keys.elementAt(index);
              List<Theater> screens = groupedTheaters[cinemaName]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.local_movies_outlined,
                        color: Colors.white,
                        size: 36,
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cinemaName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              "4.66 กม.",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  const Divider(color: Colors.white24, thickness: 1),
                  const SizedBox(height: 12),

                  ...screens.map((theater) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Theatre ${theater.theaterNo} (${theater.type})",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),

                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: actualShowtimes.map((actualTime) {
                              bool isPast = actualTime.isBefore(now);
                              bool isNextUpcoming =
                                  actualTime == nextUpcomingTime;

                              String timeStr =
                                  "${actualTime.hour.toString().padLeft(2, '0')}:${actualTime.minute.toString().padLeft(2, '0')}";

                              return OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: isNextUpcoming
                                      ? const Color(0xFFF0B90B)
                                      : Colors.white,
                                  disabledForegroundColor: Colors.white38,
                                  side: BorderSide(
                                    color: isPast
                                        ? Colors.white24
                                        : (isNextUpcoming
                                              ? const Color(0xFFF0B90B)
                                              : Colors.white54),
                                    width: 1.5,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                // NEW: Save all selected data to a map!
                                onPressed: isPast
                                    ? null
                                    : () {
                                        // THIS IS YOUR LOCAL STORAGE OBJECT!
                                        Map<String, dynamic> bookingData = {
                                          'movie_title': widget.movie.title,
                                          'date':
                                              "${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}",
                                          'cinema': cinemaName,
                                          'screen': theater.theaterNo,
                                          'time': timeStr,
                                        };

                                          print(bookingData);

                                        // Visual confirmation for you to test
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              "Saved: ${bookingData['time']} at ${bookingData['cinema']} title : ${bookingData["movie_title"]} date : ${bookingData["date"]} theaterNo : ${bookingData["screen"]}",
                                            ),
                                            backgroundColor: const Color(
                                              0xFFF0B90B,
                                            ),
                                          ),
                                        );
                                      },
                                child: Text(
                                  timeStr,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 10),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
