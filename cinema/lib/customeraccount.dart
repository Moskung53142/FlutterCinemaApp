import 'package:flutter/material.dart';
import 'editcustomerinfo.dart';
import 'data/user.dart'; // ดึงข้อมูล UserSessionData จากไฟล์นี้
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
      home: AccountManagementScreen(),
    );
  }
}

class AccountManagementScreen extends StatefulWidget {
  const AccountManagementScreen({super.key});

  @override
  State<AccountManagementScreen> createState() =>
      _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  // ดึงข้อมูลจริงจาก UserSessionData ที่เก็บไว้ตอน Login / Register
  String currentFirstName = UserSessionData.name;
  String currentLastName = UserSessionData.lastname;
  String currentEmail = UserSessionData.email;

  // ฟังก์ชันสำหรับกดไปหน้าแก้ไข และรอรับข้อมูลกลับมา
  Future<void> _navigateToEditProfile() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditProfileScreen()),
    );

    // ถ้ากดปุ่ม "บันทึก" กลับมา (มีข้อมูล result ไม่ใช่ null) ให้อัปเดตหน้าจอ
    if (result != null) {
      setState(() {
        currentFirstName = result['firstName'];
        currentLastName = result['lastName'];
        currentEmail = result['email'];

        // อัปเดตข้อมูลใน Session หลักด้วย เพื่อให้ข้อมูลตรงกันทั้งแอปเมื่อกลับไปหน้าอื่นๆ
        UserSessionData.name = result['firstName'];
        UserSessionData.lastname = result['lastName'];
        UserSessionData.email = result['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            // ลบประวัติหน้าเดิมทิ้ง และกลับไปที่หน้า home.dart
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MovieHomePage()),
              (route) => false,
            );
          },
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ข้อมูลส่วนตัว',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: _navigateToEditProfile,
                  child: const Text(
                    'แก้ไข',
                    style: TextStyle(color: Color(0xFFE2B93B), fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        'ชื่อ : ',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Expanded(child: _buildDataBox(currentFirstName)),
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
                      Expanded(child: _buildDataBox(currentLastName)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            const Text(
              'ข้อมูลติดต่อ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                const Text(
                  'อีเมล : ',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Expanded(child: _buildDataBox(currentEmail)),
              ],
            ),
            const SizedBox(height: 12),

            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: _navigateToEditProfile,
                child: const Text(
                  'เปลี่ยนรหัสผ่าน',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataBox(String text) {
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
        style: const TextStyle(color: Colors.black, fontSize: 12),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
