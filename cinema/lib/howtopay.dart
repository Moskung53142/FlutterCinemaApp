import 'package:flutter/material.dart';
import 'addcardpay.dart'; // สำคัญ: import หน้าเพิ่มบัตรเครดิต
import 'addbankpay.dart'; // สำคัญ: import หน้าเพิ่มบัญชีธนาคารเพิ่มเข้ามา
import 'package:cinema/showtimepage/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentMethodScreen(),
    );
  }
}

// เปลี่ยนเป็น StatefulWidget เพื่อรอรับค่าจากหน้าเพิ่มบัตรมาเก็บไว้
class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  // ตัวแปรเก็บข้อมูลบัตรที่รับกลับมา
  Map<String, dynamic>? savedCardDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () {
            // กลับไปที่หน้า home.dart
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MovieHomePage()),
              (route) => false,
            );
          },
        ),
        title: const Text(
          'วิธีการชำระเงิน',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'บันทึกข้อมูลการชำระเงินเพื่อการจองที่รวดเร็วยิ่งขึ้น',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 24),

            // กล่องที่ 1: บัตรเครดิต/เดบิต
            _buildPaymentOptionBox(
              title: 'เพิ่มข้อมูลบัตรเครดิต/บัตรเดบิต',
              subtitle: 'รองรับหลายผู้ให้บริการจากทั่วโลก',
              icon: Icons.credit_card,
              onTap: () async {
                // รอรับข้อมูลเมื่อผู้ใช้กดปุ่ม "บันทึก" จากหน้า AddCardPayScreen
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddCardPayScreen()),
                );

                if (result != null) {
                  setState(() {
                    savedCardDetails = result;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('บันทึกบัตรของ ${result['cardName']} เรียบร้อย!')),
                  );
                }
              },
            ),
            const SizedBox(height: 16),

            // กล่องที่ 2: บัญชีธนาคาร (เพิ่ม onTap เพื่อเปลี่ยนหน้าไปที่ addbankpay.dart)
            _buildPaymentOptionBox(
              title: 'เพิ่มข้อมูลบัญชีธนาคาร',
              subtitle: 'รองรับธนาคารทั่วประเทศไทย',
              icon: Icons.account_balance,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddBankAccountScreen()),
                );
              },
            ),
            const SizedBox(height: 16),

            // กล่องที่ 3: เพิ่มข้อมูลภายหลัง
            _buildPaymentOptionBox(
              title: 'ฉันขอเพิ่มข้อมูลภายหลัง',
              subtitle: null,
              icon: Icons.arrow_circle_right,
            ),
          ],
        ),
      ),
    );
  }

  // Widget สร้างกล่องตัวเลือก
  Widget _buildPaymentOptionBox({
    required String title,
    String? subtitle,
    required IconData icon,
    VoidCallback? onTap, 
  }) {
    return GestureDetector( 
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.white30, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 8),
                    Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 16),
            Icon(icon, color: Colors.white, size: 36),
          ],
        ),
      ),
    );
  }
}