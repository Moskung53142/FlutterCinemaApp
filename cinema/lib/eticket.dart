import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ETicketScreen(),
    );
  }
}

class ETicketScreen extends StatelessWidget {
  const ETicketScreen({super.key});

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
            // เพิ่มคำสั่ง Navigator.pop ตรงนี้ เพื่อย้อนกลับไปหน้าก่อนหน้า (historyon.dart)
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'E-Ticket',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      // เปลี่ยนจาก Center เป็นโครงสร้างด้านล่างนี้เพื่อดันขึ้นบน
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 48.0), // ปรับความห่างจากขอบบนได้ตรงตัวเลขนี้ครับ
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 320, // ขนาดความกว้างของกรอบ QR Code ตามดราฟต์เดิม
                height: 320,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png', // รูปภาพ QR Code จำลอง
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}