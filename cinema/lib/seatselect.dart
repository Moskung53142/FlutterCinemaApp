import 'package:cinema/seatselected/seattopbar.dart';
import 'package:cinema/seatselected/seatui.dart';
import 'package:flutter/material.dart';

// NEW: Import the UI file we just created! (Adjust path if necessary)


void main() {
  Map<String, dynamic> mockBookingData = {
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
      // REPLACE the body with our new interactive SeatUI component!
      body: SeatUI(bookingData: widget.bookingData),
    );
  }
}