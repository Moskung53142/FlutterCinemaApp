import 'package:flutter/material.dart';

class HorizontalDatePicker extends StatefulWidget {
  final String movieStartDate;
  // NEW: Callback to send the selected date back to the parent
  final Function(DateTime) onDateSelected;

  const HorizontalDatePicker({
    super.key,
    required this.movieStartDate,
    required this.onDateSelected,
  });

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
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime startDate = _parseThaiDate(widget.movieStartDate);

    int daysPassed = today.difference(startDate).inDays;

    if (daysPassed < 0) {
      dates = List.generate(
        30,
        (index) => startDate.add(Duration(days: index)),
      );
    } else if (daysPassed < 30) {
      int remainingDays = 30 - daysPassed;
      dates = List.generate(
        remainingDays,
        (index) => today.add(Duration(days: index)),
      );
    } else {
      dates = [];
    }

    // NEW: Automatically send the first available date to the parent when the widget loads
    if (dates.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onDateSelected(dates[0]);
      });
    }
  }

  DateTime _parseThaiDate(String dateString) {
    try {
      List<String> parts = dateString.split(' ');
      int day = int.parse(parts[0]);
      int month = thaiMonths.indexOf(parts[1]) + 1;
      int year = int.parse(parts[2]) - 543;

      return DateTime(year, month, day);
    } catch (e) {
      return DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dates.isEmpty) {
      return Container(
        color: Colors.black,
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          'ภาพยนตร์เรื่องนี้ออกจากการฉายแล้ว',
          style: TextStyle(color: Colors.white54, fontSize: 16),
        ),
      );
    }

    String currentMonthName = thaiMonths[dates[selectedIndex].month - 1];
    DateTime now = DateTime.now();

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            currentMonthName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dates.length,
              itemBuilder: (context, index) {
                DateTime date = dates[index];
                bool isSelected = index == selectedIndex;

                bool isActuallyToday =
                    date.year == now.year &&
                    date.month == now.month &&
                    date.day == now.day;

                String dayText = isActuallyToday
                    ? 'วันนี้'
                    : thaiDays[date.weekday - 1];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    // NEW: Send the new date to the parent when clicked!
                    widget.onDateSelected(date);
                  },
                  child: Container(
                    width: 60,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFF0B90B)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
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
