import 'package:flutter/material.dart';
import 'data/user.dart'; // สำคัญ: นำเข้า user.dart เพื่อเชื่อมข้อมูล

class EditProfileScreen extends StatefulWidget {
  // ไม่ต้องรับค่าผ่าน Constructor แล้ว เพราะดึงจาก user.dart โดยตรงได้เลย
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    // ดึงค่าเริ่มต้นจาก userListData ตำแหน่งแรกสุด มาใส่ในช่องพิมพ์
    _firstNameController = TextEditingController(text: userListData[0].name);
    _lastNameController = TextEditingController(text: userListData[0].lastname);
    _emailController = TextEditingController(text: userListData[0].email);
    
    // ช่องรหัสผ่านปล่อยว่างไว้ให้กรอกใหม่
    _passwordController = TextEditingController(); 
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
            Navigator.pop(context); // กดย้อนกลับโดยไม่บันทึก
          },
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
      body: SingleChildScrollView( 
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ข้อมูลส่วนตัว',
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Text('ชื่อ : ', style: TextStyle(color: Colors.white, fontSize: 12)),
                      Expanded(child: _buildInputBox(_firstNameController)),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    children: [
                      const Text('นามสกุล : ', style: TextStyle(color: Colors.white, fontSize: 12)),
                      Expanded(child: _buildInputBox(_lastNameController)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            const Text(
              'ข้อมูลติดต่อ',
              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            _buildContactRow('อีเมล : ', _emailController),
            const SizedBox(height: 12),
            _buildContactRow('รหัสผ่านใหม่ : ', _passwordController, isPassword: true),
            const SizedBox(height: 12),
            _buildContactRow('ยืนยันรหัสผ่าน : ', _confirmPasswordController, isPassword: true),
            const SizedBox(height: 24),

            // ปุ่ม: บันทึก
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  // เช็กรหัสผ่านใหม่ (ถ้ามีการพิมพ์เข้ามา)
                  String newPassword = userListData[0].password; // ค่าเริ่มต้นใช้รหัสเดิมไปก่อน
                  
                  if (_passwordController.text.isNotEmpty) {
                    if (_passwordController.text == _confirmPasswordController.text) {
                      newPassword = _passwordController.text; // ถ้าตรงกันให้ใช้รหัสใหม่
                    } else {
                      // ถ้าพิมพ์ไม่ตรงกัน โชว์แจ้งเตือนแล้วหยุดทำงาน
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('รหัสผ่านและยืนยันรหัสผ่านไม่ตรงกัน!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return; // หยุดทำงานตรงนี้ ไม่ย้อนกลับ
                    }
                  }

                  // 1. อัปเดตข้อมูลกลับเข้าไปในตัวแปร userListData[0] ในไฟล์ user.dart
                  userListData[0] = UserList(
                    name: _firstNameController.text,
                    lastname: _lastNameController.text,
                    email: _emailController.text,
                    password: newPassword,
                  );

                  // 2. จัดแพ็กข้อมูลเพื่อส่งกลับไปให้หน้า customeraccount.dart อัปเดตจอ
                  final updatedData = {
                    'firstName': _firstNameController.text,
                    'lastName': _lastNameController.text,
                    'email': _emailController.text,
                  };
                  
                  // เด้งกลับไปหน้าเดิมพร้อมข้อมูล
                  Navigator.pop(context, updatedData);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE50914),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'บันทึก',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(String label, TextEditingController controller, {bool isPassword = false}) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ),
        Expanded(child: _buildInputBox(controller, isPassword: isPassword)),
      ],
    );
  }

  Widget _buildInputBox(TextEditingController controller, {bool isPassword = false}) {
    return Container(
      height: 28,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.black, fontSize: 12),
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          border: InputBorder.none,
        ),
      ),
    );
  }
}