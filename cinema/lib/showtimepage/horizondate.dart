import 'package:flutter/material.dart';

class HorizontalDatePicker extends StatefulWidget {
  final String movieStartDate;

  const HorizontalDatePicker({super.key, required this.movieStartDate});

  @override
  State<HorizontalDatePicker> createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  late List<DateTime> dates;
  int selectedIndex = 0;

  // Thai translation helpers
  final List<String> thaiMonths = [
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม',
  ];

  final List<String> thaiDays = ['จ.', 'อ.', 'พ.', 'พฤ.', 'ศ.', 'ส.', 'อา.'];

  @override
  void initState() {
    super.initState();
    _generateDates();
  }

  void _generateDates() {
    DateTime now = DateTime.now();
    // Reset time to midnight to calculate exact days accurately
    DateTime today = DateTime(now.year, now.month, now.day);

    // Parse the start date from the text (e.g. "1 มีนาคม 2569")
    DateTime startDate = _parseThaiDate(widget.movieStartDate);

    // Calculate the difference: How many days have passed since the movie started?
    int daysPassed = today.difference(startDate).inDays;

    if (daysPassed < 0) {
      // 1. FUTURE MOVIE: The movie hasn't started yet.
      // Show the full 30 days starting from the movie's future start date.
      dates = List.generate(
        30,
        (index) => startDate.add(Duration(days: index)),
      );
    } else if (daysPassed < 30) {
      // 2. CURRENTLY SHOWING: The movie started a few days ago.
      // We only show the *remaining* days available out of the 30-day window, starting from TODAY.
      int remainingDays = 30 - daysPassed;
      dates = List.generate(
        remainingDays,
        (index) => today.add(Duration(days: index)),
      );
    } else {
      // 3. EXPIRED: It has been more than 30 days. No showtimes left.
      dates = [];
    }
  }

  // Helper method to convert Thai string date into a Dart DateTime
  DateTime _parseThaiDate(String dateString) {
    try {
      List<String> parts = dateString.split(' ');
      int day = int.parse(parts[0]);
      int month = thaiMonths.indexOf(parts[1]) + 1;
      int year =
          int.parse(parts[2]) -
          543; // Convert พ.ศ. (Buddhist Era) to ค.ศ. (Christian Era)

      return DateTime(year, month, day);
    } catch (e) {
      return DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    // If the movie has expired (dates list is empty), show a message instead of breaking
    if (dates.isEmpty) {
      return Container(
        color: Colors.black,
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          'ภาพยนตร์เรื่องนี้ออกจากการฉายแล้ว', // "This movie has left theaters"
          style: TextStyle(color: Colors.white54, fontSize: 16),
        ),
      );
    }

    // Get the month of the currently selected date
    String currentMonthName = thaiMonths[dates[selectedIndex].month - 1];
    DateTime now = DateTime.now();

    return Container(
      color: Colors.black, // Dark background to match your image
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- MONTH HEADER ---
          Text(
            currentMonthName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // --- HORIZONTAL DATE LIST ---
          SizedBox(
            height: 70, // Fixed height for the scrollable row
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              itemBuilder: (context, index) {
                DateTime date = dates[index];
                bool isSelected = index == selectedIndex;

                // Check if this specific box is ACTUALLY today's real date
                bool isActuallyToday =
                    date.year == now.year &&
                    date.month == now.month &&
                    date.day == now.day;

                // Determine what to show on top (Today vs Day of Week)
                String dayText = isActuallyToday
                    ? 'วันนี้'
                    : thaiDays[date.weekday - 1];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      // Yellow if selected, transparent if not
                      color: isSelected
                          ? const Color(0xFFF0B90B)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      // White border if NOT selected
                      border: isSelected
                          ? null
                          : Border.all(color: Colors.white54, width: 1.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dayText,
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.white70,
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
