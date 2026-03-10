import 'package:cinema/paymentpage/paymenttopbar.dart';
import 'package:flutter/material.dart';

void main() {
  // Mock data for standalone testing
  Map<String, dynamic> mockBookingData = {
    'user_index': 0,
    'user_name': 'Somchai Jai-dee',
    'user_email': 'somchai@email.com',
    'movie_title': 'SuperMan',
    'theaterName': 'รัชโยธิน ซีนีเพล็กซ์',
    'screen': 6,
    'date': '29 มกราคม 2569',
    'time': '20:00',
    // Lots of mock seats to prove the overflow is fixed!
    'selected_seats': ['A7', 'A8', 'B7', 'B8', 'C7', 'C8', 'D7', 'D8'],
    'total_price': 1280,
  };

  runApp(
    MaterialApp(
      title: "Bank Payment",
      debugShowCheckedModeBanner: false,
      home: BankTransferPaymentScreen(bookingData: mockBookingData),
    ),
  );
}

class BankTransferPaymentScreen extends StatelessWidget {
  final Map<String, dynamic> bookingData;

  const BankTransferPaymentScreen({super.key, required this.bookingData});

  @override
  Widget build(BuildContext context) {
    List<String> seats = List<String>.from(bookingData['selected_seats'] ?? []);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(148, 92, 92, 92),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const PaymentTopbar(), // Top navigation steps
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==========================================
                  // 1. USER INFORMATION
                  // ==========================================
                  const Text(
                    "ข้อมูลผู้จอง",
                    style: TextStyle(
                      color: Color(0xFFF0B90B),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ชื่อ: ${bookingData['user_name']}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "อีเมล: ${bookingData['user_email']}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ==========================================
                  // 2. BOOKING SUMMARY
                  // ==========================================
                  const Text(
                    "สรุปรายการสั่งซื้อ",
                    style: TextStyle(
                      color: Color(0xFFF0B90B),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ภาพยนตร์: ${bookingData['movie_title']}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "สาขา: ${bookingData['theaterName']}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "โรงภาพยนตร์: Theatre ${bookingData['screen']}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "รอบฉาย: ${bookingData['date']} | ${bookingData['time']} น.",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const Divider(
                          color: Colors.white24,
                          height: 20,
                          thickness: 1,
                        ),

                        // FIX: Seats can now wrap multiple lines without squeezing the price!
                        Text(
                          "ที่นั่ง: ${seats.join(', ')}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // FIX: Total Price is moved down to its own clean row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "ราคารวม:",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "฿${bookingData['total_price']}",
                              style: const TextStyle(
                                color: Color(0xFFF0B90B),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // ==========================================
                  // 3. MOCK QR CODE SECTION
                  // ==========================================
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          "สแกน QR Code เพื่อชำระเงิน",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.qr_code_2,
                            size: 120,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          "หรือโอนผ่านบัญชี: 123-4-56789-0",
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ==========================================
          // 4. BOTTOM BAR (CONFIRM BUTTON)
          // ==========================================
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            decoration: const BoxDecoration(
              color: Color(0xFF2C2C2C),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("รอเชื่อมต่อหน้าออกตั๋วในอนาคต!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: Text(
                  "ยืนยันการโอนเงิน ฿${bookingData['total_price']}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
