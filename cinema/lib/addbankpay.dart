import 'package:flutter/material.dart';
import 'addbankinfo.dart'; // สำคัญ: import หน้ากรอกข้อมูลบัญชีเข้ามา

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddBankAccountScreen(),
    );
  }
}

class AddBankAccountScreen extends StatelessWidget {
  const AddBankAccountScreen({super.key});

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
            Navigator.pop(context); // กดเพื่อย้อนกลับไป howtopay
          },
        ),
        title: const Text(
          'เพิ่มข้อมูลบัญชีธนาคาร',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ข้อความอธิบายด้านบน
              const Text(
                'เชื่อมต่อบัญชีธนาคารเพื่อการชำระเงินที่รวดเร็วยิ่งขึ้น',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),

              // ปุ่มที่ 1: ธนาคารกสิกรไทย
              _buildBankButton(
                thaiName: 'ธนาคารกสิกรไทย',
                engName: 'Kasikornthai Bank',
                imagePath: 'asset/image/kbank.png',
                onTap: () {
                  // เมื่อกดแล้วจะเปลี่ยนไปหน้า addbankinfo.dart
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BankAccountDetailScreen()),
                  );
                },
              ),

              // ปุ่มที่ 2: ธนาคารไทยพาณิชย์
              _buildBankButton(
                thaiName: 'ธนาคารไทยพาณิชย์',
                engName: 'Siam Commercial Bank',
                imagePath: 'asset/image/scb.png',
                onTap: () {},
              ),

              // ปุ่มที่ 3: ธนาคารกรุงเทพ
              _buildBankButton(
                thaiName: 'ธนาคารกรุงเทพ',
                engName: 'Bangkok Bank',
                imagePath: 'asset/image/bangkokbank.png',
                onTap: () {},
              ),

              // ปุ่มที่ 4: ธนาคารกรุงศรีอยุธยา
              _buildBankButton(
                thaiName: 'ธนาคารกรุงศรีอยุธยา',
                engName: 'Bank of Ayudhya',
                imagePath: 'asset/image/krungsri.png',
                onTap: () {},
              ),

              // ปุ่มที่ 5: ธนาคารกรุงไทย
              _buildBankButton(
                thaiName: 'ธนาคารกรุงไทย',
                engName: 'Krungthai Bank',
                imagePath: 'asset/image/krungthai.png',
                onTap: () {},
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Widget สำหรับสร้างกล่องธนาคาร 
  Widget _buildBankButton({
    required String thaiName,
    required String engName,
    required String imagePath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20), 
        decoration: BoxDecoration(
          color: Colors.black, 
          border: Border.all(color: Colors.white30, width: 1.5), 
          borderRadius: BorderRadius.circular(12), 
        ),
        child: Row(
          children: [
            // โลโก้ธนาคาร 
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(6),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 16),
            
            // ชื่อธนาคาร
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    thaiName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    engName,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            
            // ไอคอนลูกศรชี้ขวา 
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white54,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}