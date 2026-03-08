import 'package:flutter/material.dart';

class BankTransferPaymentScreen extends StatelessWidget {
  final Map<String, dynamic> bookingData;

  const BankTransferPaymentScreen({super.key, required this.bookingData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "ชำระผ่านบัญชีธนาคาร",
          style: TextStyle(color: Colors.white),
        ),
        leading: const BackButton(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_balance, color: Colors.white, size: 80),
            const SizedBox(height: 20),
            Text(
              "ยอดชำระ: ฿${bookingData['total_price']}",
              style: const TextStyle(
                color: Color(0xFFF0B90B),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "(หน้าจอสำหรับโอนเงิน / สแกน QR Code)",
              style: TextStyle(color: Colors.white54, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
