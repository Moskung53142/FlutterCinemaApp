import 'package:cinema/seatselected/seattopbar.dart';
import 'package:cinema/seatselected/seatui.dart';
import 'package:flutter/material.dart';

void main() {
  // NEW: Added the User mock data here so the page can be tested standalone
  // without crashing when it tries to send user data to the next page!
  Map<String, dynamic> mockBookingData = {
    'user_index': 0,
    'user_name': 'name surname',
    'user_email': 'email@email.com',
    'movie_index': 0,
    'theaterName': 'รัชโยธิน ซีนีเพล็กซ์',
    'movie_title': 'SuperMan',
    'date': '29 มกราคม 2569',
    'cinema': 'รัชโยธิน ซีนีเพล็กซ์',
    'screen': 6,
    'time': '20:00',
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
  final Map<String, dynamic> bookingData;

  const Seatselected({super.key, required this.bookingData});

  @override
  State<Seatselected> createState() => _SeatselectedState();
}

class _SeatselectedState extends State<Seatselected> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Matching the dark theme
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(148, 92, 92, 92),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Seattopbar(), // Top navigation steps
      ),
      // Uses the interactive SeatUI component
      body: SeatUI(bookingData: widget.bookingData),
    );
  }
}
