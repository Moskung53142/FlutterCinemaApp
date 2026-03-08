import 'package:flutter/material.dart';

class CreditCardPaymentScreen extends StatelessWidget {
  final Map<String, dynamic> bookingData;

  const CreditCardPaymentScreen({super.key, required this.bookingData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("ชำระผ่านบัตรเครดิต", style: TextStyle(color: Colors.white)),
        leading: const BackButton(color: Colors.white),
      ),
      body: Column(
        children: [
          // Main Content
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.credit_card, color: Colors.white, size: 80),
                  const SizedBox(height: 20),
                  Text(
                    "ยอดชำระ: ฿${bookingData['total_price']}",
                    style: const TextStyle(color: Color(0xFFF0B90B), fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "(หน้าจอสำหรับกรอกบัตรเครดิต)",
                    style: TextStyle(color: Colors.white54, fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          
          // ==========================================
          // BOTTOM BAR (CONFIRM BUTTON)
          // ==========================================
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            decoration: const BoxDecoration(
              color: Color(0xFF2C2C2C), // Dark grey bottom sheet
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  // ==========================================
                  // PREPARED FOR FUTURE NAVIGATION
                  // ==========================================
                  // When your Ticket/Success page is ready, uncomment the code below:
                  
                  /*
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // Replace 'TicketSuccessScreen' with your actual future page name
                      builder: (context) => TicketSuccessScreen(bookingData: bookingData), 
                    ),
                  );
                  */

                  // Temporary popup just to test the button for now
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("รอเชื่อมต่อหน้าออกตั๋วในอนาคต!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text(
                  "ยืนยันการชำระเงิน",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}