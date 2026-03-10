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
      home: AccountManagementScreen(),
    );
  }
}

class AccountManagementScreen extends StatelessWidget {
  const AccountManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () {},
        ),
        title: const Text(
          'จัดการบัญชี',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ส่วนหัว: ข้อมูลส่วนตัว
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'ข้อมูลส่วนตัว',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'แก้ไข',
                  style: TextStyle(
                    color: Color(0xFFE2B93B), // สีเหลืองทองตามแบบ
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // แถว: ชื่อ และ นามสกุล
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        'ชื่อ : ',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Expanded(child: _buildInputBox('สมชาย')),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        'นามสกุล : ',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Expanded(child: _buildInputBox('หลังจาน')),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // ส่วนหัว: ข้อมูลติดต่อ
            const Text(
              'ข้อมูลติดต่อ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // แถว: อีเมล
            Row(
              children: [
                const Text(
                  'อีเมล : ',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Expanded(child: _buildInputBox('')),
              ],
            ),
            const SizedBox(height: 12),

            // ลิงก์: เปลี่ยนรหัสผ่าน
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'เปลี่ยนรหัสผ่าน',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget สำหรับสร้างกล่องข้อความสีขาวเพื่อให้ได้ดีไซน์เหมือนภาพเป๊ะ
  Widget _buildInputBox(String text) {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
    );
  }
}