import 'package:cinema/seatselected/seattopbar.dart';
import 'package:flutter/material.dart';

void main() {
  // Create mock data so the page can be tested standalone
  Map<String, dynamic> mockBookingData = {
    'movie_title': 'Mock Movie Title (Test)',
    'date': '29/1/2024',
    'cinema': 'Mock Cinema Name',
    'screen': 1,
    'time': '15:00',
  };

  runApp(
    MaterialApp(
      title: "Seat Select page",
      debugShowCheckedModeBanner: false,
      home: Seatselected(bookingData: mockBookingData),
    ),
  );
}

class Seatselected extends StatefulWidget {
  // 1. Tell this screen to expect the bookingData Map
  final Map<String, dynamic> bookingData;

  const Seatselected({super.key, required this.bookingData});

  @override
  State<Seatselected> createState() => _SeatselectedState();
}

class _SeatselectedState extends State<Seatselected> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Keep the dark theme
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(148, 92, 92, 92),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Seattopbar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Color(0xFFF0B90B), size: 80),
            const SizedBox(height: 20),
            const Text(
              "ข้อมูลที่ส่งมาสำเร็จ! (Data Received)",
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const SizedBox(height: 20),

            // 2. Display the received data!
            Text(
              "เรื่อง: ${widget.bookingData['movie_title']}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "วันที่: ${widget.bookingData['date']}",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              "โรง: Theatre ${widget.bookingData['screen']}",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              "เวลา: ${widget.bookingData['time']}",
              style: const TextStyle(
                color: Color(0xFFF0B90B),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
