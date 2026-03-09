import 'package:cinema/paymentpage/paymenttopbar.dart';
import 'package:cinema/paymentpage/paymentui.dart';
import 'package:flutter/material.dart';

void main() {
  // Mock data so the page can be tested standalone
  Map<String, dynamic> mockBookingData = {
    // -- ADDED USER MOCK DATA --
    'user_index': 0,
    'user_name': 'name surname',
    'user_email': 'email@email.com',

    // -- EXISTING MOCK DATA --
    'movie_index': 0,
    'theaterName': 'รัชโยธิน ซีนีเพล็กซ์',
    'movie_title': 'SuperMan',
    'date': '29 มกราคม 2569',
    'cinema': 'รัชโยธิน ซีนีเพล็กซ์',
    'screen': 6,
    'time': '20:00',
    'selected_seats': ['D7', 'D8'],
    'total_price': 320,
  };

  runApp(
    MaterialApp(
      title: "Payment Select page",
      debugShowCheckedModeBanner: false,
      home: Paymentselect(bookingData: mockBookingData),
    ),
  );
}

class Paymentselect extends StatefulWidget {
  final Map<String, dynamic> bookingData;

  const Paymentselect({super.key, required this.bookingData});

  @override
  State<Paymentselect> createState() => _PaymentselectState();
}

class _PaymentselectState extends State<Paymentselect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Keep the dark theme
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(148, 92, 92, 92),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const PaymentTopbar(), // Top navigation steps
      ),
      // Uses the interactive PaymentUI component!
      body: PaymentUI(bookingData: widget.bookingData),
    );
  }
}
