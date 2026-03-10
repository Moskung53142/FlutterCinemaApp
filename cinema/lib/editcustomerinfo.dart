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
      home: EditProfileScreen(),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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
          'แก้ไขข้อมูลผู้ใช้',
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
            const Text(
              'ข้อมูลส่วนตัว',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
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
                      Expanded(child: _buildInputBox('หลังอาน')),
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
            _buildContactRow('อีเมล : '),
            const SizedBox(height: 12),

            // แถว: รหัสผ่าน
            _buildContactRow('รหัสผ่าน : '),
            const SizedBox(height: 12),

            // แถว: ยืนยันรหัสผ่าน
            _buildContactRow('ยืนยันรหัสผ่าน : '),
            const SizedBox(height: 24),

            // ปุ่ม: บันทึก
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE50914), // สีแดงอิงตามแบบ
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'บันทึก',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget สำหรับสร้างแถวของข้อมูลติดต่อเพื่อให้ Layout ตรงกันเป๊ะ
  Widget _buildContactRow(String label) {
    return Row(
      children: [
        SizedBox(
          width: 90, // ล็อกความกว้างของข้อความ เพื่อให้กล่องสีขาวจัดเรียงตรงกัน
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
        Expanded(child: _buildInputBox('')),
      ],
    );
  }

  // Widget สำหรับสร้างกล่องข้อความสีขาว (ทำเป็น Container เพื่อให้ UI ออกมาเหมือนในภาพ 100%)
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