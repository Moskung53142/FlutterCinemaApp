import 'package:cinema/data/user.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  List<bool> isEyeOpen = [false, false];

  void register(BuildContext context) {
    String fullName = nameController.text.trim();

    List<String> nameParts = fullName.split(" ");

    String name = "";
    String surname = "";

    if (nameParts.isNotEmpty) {
      name = nameParts[0];

      if (nameParts.length > 1) {
        surname = nameParts.sublist(1).join(" ");
      }
    }

    String email = emailController.text;
    String password = passwordController.text;
    String confirmpassword = confirmPasswordController.text;

    if (password != confirmpassword) {
      ScaffoldMessenger.of(
        context,
      ).clearSnackBars(); // ล้างอันเก่าก่อนเพื่อความลื่นไหล

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "รหัสผ่านไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.redAccent.shade700, // สีแดงเข้มเข้ากับธีมหนัง
          behavior: SnackBarBehavior.floating, // ทำให้แถบลอยขึ้น
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // ขอบมนดูทันสมัย
          ),
          margin: const EdgeInsets.all(20), // ระยะห่างจากขอบจอ
          duration: const Duration(seconds: 3), // โชว์ 3 วินาทีแล้วหายไป
        ),
      );

      return;
    }
    try {
      userListData.add(
        UserList(
          name: name,
          lastname: surname,
          email: email,
          password: password,
        ),
      );

      UserSessionData.name = name;
      UserSessionData.lastname = surname;
      UserSessionData.email = email;
      UserSessionData.password = password;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "สมัครสมาชิกสำเร็จ!",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.redAccent.shade700, // สีแดงเข้มเข้ากับธีมหนัง
          behavior: SnackBarBehavior.floating, // ทำให้แถบลอยขึ้น
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // ขอบมนดูทันสมัย
          ),
          margin: const EdgeInsets.all(20), // ระยะห่างจากขอบจอ
          duration: const Duration(seconds: 3), // โชว์ 3 วินาทีแล้วหายไป
        ),
      );

      Navigator.pushReplacementNamed(context, '/home');

    } catch (error) {
      print("เกิดข้อผิดพลาด: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- จุดใส่รูปพื้นหลัง (Background) ---
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'asset/image/authBackground.jpg',
                ), // เปลี่ยนชื่อไฟล์ตามจริง
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const Text(
                    "กรุณากรอกข้อมูลเพื่อสมัครสมาชิก",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Toggle Button (สลับสี)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              "เข้าสู่ระบบ",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              "สมัครสมาชิก",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

                  _buildInputLabel("ชื่อ - สกุล"),
                  _buildTextField(
                    hint: "สมชาย หลังอาน",
                    icon: Icons.person_outline,
                    controller: nameController,
                  ),
                  const SizedBox(height: 15),
                  _buildInputLabel("อีเมล"),
                  _buildTextField(
                    hint: "example@email.com",
                    icon: Icons.email_outlined,
                    controller: emailController,
                  ),
                  const SizedBox(height: 15),
                  _buildInputLabel("รหัสผ่าน"),
                  _buildTextField(
                    hint: "กรอกรหัสผ่านของคุณ",
                    icon: Icons.lock_outline,
                    isPassword: true,
                    controller: passwordController,
                    eyeIndex: 0,
                  ),
                  const SizedBox(height: 15),
                  _buildInputLabel("ยืนยันรหัสผ่าน"),
                  _buildTextField(
                    hint: "กรอกรหัสผ่านของคุณ",
                    icon: Icons.lock_outline,
                    isPassword: true,
                    controller: confirmPasswordController,
                    eyeIndex: 1,
                  ),

                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => register(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "สมัครสมาชิก",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
    int eyeIndex = 0,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? !isEyeOpen[eyeIndex] : false,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.white),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isEyeOpen[eyeIndex] ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isEyeOpen[eyeIndex] = !(isEyeOpen[eyeIndex]);
                  });
                },
              )
            : null,
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
