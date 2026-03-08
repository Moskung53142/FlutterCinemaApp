import 'package:flutter/material.dart';
import 'package:cinema/model/movie_list.dart'; // Make sure path is correct
import 'package:cinema/model/theater.dart'; // Make sure path is correct

class Theatertype extends StatefulWidget {
  const Theatertype({super.key});

  @override
  State<Theatertype> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Theatertype> {
  // 0 = ทั้งหมด, 1 = IMAX, 2 = 4DX, 3 = Kids
  int selectedIndex = 0;
  final List<String> types = ["ทั้งหมด", "IMAX", "4DX", "Kids"];

  // Helper function to calculate showtimes from 08:00 to 00:00 based on movie duration
  List<DateTime> getShowtimes(int durationMinutes) {
    List<DateTime> times = [];

    DateTime now = DateTime.now();
    // 1. Set the first showtime to exactly 08:00 today
    DateTime currentTime = DateTime(now.year, now.month, now.day, 8, 0);

    // 2. Set the limit to 00:00 (Midnight of the NEXT day)
    DateTime endTimeLimit = DateTime(now.year, now.month, now.day + 1, 0, 0);

    // 3. Keep generating times until it passes midnight
    while (currentTime.isBefore(endTimeLimit)) {
      times.add(currentTime);

      // Add the movie duration to get the next showtime
      currentTime = currentTime.add(Duration(minutes: durationMinutes));
    }

    return times;
  }

  @override
  Widget build(BuildContext context) {
    String selectedType = types[selectedIndex];

    // 1. Group the theaters by their name
    // This creates a map like: { "เวสเกต สาขา ดาวอังคาร": [Theater 1, Theater 2], ... }
    Map<String, List<Theater>> groupedTheaters = {};

    for (var theater in thearterList) {
      // Apply the type filter first
      if (selectedType == "ทั้งหมด" || theater.type == selectedType) {
        if (!groupedTheaters.containsKey(theater.theaterName)) {
          groupedTheaters[theater.theaterName] =
              []; // Create new list if cinema name doesn't exist yet
        }
        groupedTheaters[theater.theaterName]!.add(
          theater,
        ); // Add screen to that cinema
      }
    }

    // 2. Calculate times based on the duration of the movie
    List<DateTime> showtimes = getShowtimes(appMovieList[0].duration);

    // 3. Find the next upcoming time to highlight it
    DateTime now = DateTime.now();
    DateTime? nextUpcomingTime;
    try {
      // Find the first time that is AFTER the current time
      nextUpcomingTime = showtimes.firstWhere((time) => time.isAfter(now));
    } catch (e) {
      nextUpcomingTime = null; // No more showtimes today
    }

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================
          // 1. THE THEATER TYPE BUTTON ROW
          // ==========================================
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

          // ==========================================
          // 2. THE GROUPED THEATER LIST UI
          // ==========================================
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: groupedTheaters.length, // Count unique cinema names
            itemBuilder: (context, index) {
              // Get the Cinema Name and the list of Screens for this Cinema
              String cinemaName = groupedTheaters.keys.elementAt(index);
              List<Theater> screens = groupedTheaters[cinemaName]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 1. Main Cinema Header (Renders only ONCE per cinema) ---
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
                              "4.66 กม.", // Mocked distance
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

                  // --- 2. List the Screens (Theater 1, Theater 2, etc.) under this Cinema ---
                  ...screens.map((theater) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Theater Number & Type
                          Text(
                            "Theatre ${theater.theaterNo} (${theater.type})",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Showtimes Buttons (Using Wrap so they drop to a new line if there are many)
                          Wrap(
                            spacing: 12, // Horizontal spacing between buttons
                            runSpacing:
                                12, // Vertical spacing between lines of buttons
                            children: showtimes.map((time) {
                              bool isPast = time.isBefore(now);
                              bool isNextUpcoming = time == nextUpcomingTime;

                              String timeStr =
                                  "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

                              return OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: isNextUpcoming
                                      ? const Color(0xFFF0B90B)
                                      : Colors.white,
                                  disabledForegroundColor: Colors
                                      .white38, // Gray text for past times
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
                                // Setting onPressed to null automatically disables the button!
                                onPressed: isPast
                                    ? null
                                    : () {
                                        // Logic when a user clicks a time
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
                  }).toList(), // End of screens loop

                  const SizedBox(
                    height: 10,
                  ), // Spacing before the next Cinema Name
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
