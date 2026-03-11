import 'package:cinema/data/user.dart';
import 'package:flutter/material.dart';

class ForgetpasswordPage extends StatefulWidget {
  const ForgetpasswordPage({super.key});

  @override
  State<ForgetpasswordPage> createState() => ForgetpasswordPageState();
}

class ForgetpasswordPageState extends State<ForgetpasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newConfirmPasswordController =
      TextEditingController();

  List<bool> isEyeOpen = [false, false];

  void RePassword(BuildContext context) {
    String email = emailController.text;
    String newPassword = newPasswordController.text;
    String newConfirmPassword = newConfirmPasswordController.text;

    bool foundEmail = userListData.any((data) => data.email == email);

    if (newPassword != newConfirmPassword || !foundEmail) {
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
      final foundUserIndex = userListData.indexWhere(
        (data) => data.email == email,
      );

      if (foundUserIndex != -1) {
        final oldData = userListData[foundUserIndex];

        userListData[foundUserIndex] = UserList(
          name: oldData.name,
          lastname: oldData.lastname,
          email: oldData.email,
          password: newPassword,
        );

        UserSessionData.email = userListData[foundUserIndex].email;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.white),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "เปลี่ยนรหัสผ่านใหม่สำเร็จ!",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
            backgroundColor:
                Colors.redAccent.shade700, // สีแดงเข้มเข้ากับธีมหนัง
            behavior: SnackBarBehavior.floating, // ทำให้แถบลอยขึ้น
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // ขอบมนดูทันสมัย
            ),
            margin: const EdgeInsets.all(20), // ระยะห่างจากขอบจอ
            duration: const Duration(seconds: 3), // โชว์ 3 วินาทีแล้วหายไป
          ),
        );

        Navigator.pushNamed(context, '/login');
      }
    } catch (error) {
      print("เกิดข้อผิดพลาด");
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
          SafeArea(
            child: IconButton(
              padding: const EdgeInsets.only(left: 10),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "ลืมรหัสผ่าน?",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "โปรดกรอกที่อยู่อีเมลที่ใช้สมัครบัญชีของคุณ\nและป้อนรหัสผ่านใหม่เพื่อเปลี่ยนรหัสผ่าน",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 30),
                          _buildInputLabel("อีเมล"),
                          _buildTextField(
                            hint: "example@email.com",
                            icon: Icons.email_outlined,
                            controller: emailController,
                          ),
                          const SizedBox(height: 20),
                          _buildInputLabel("รหัสผ่าน"),
                          _buildTextField(
                            hint: "กรอกรหัสผ่านของคุณ",
                            icon: Icons.lock_outline,
                            isPassword: true,
                            controller: newPasswordController,
                            eyeIndex: 0,
                          ),
                          const SizedBox(height: 20),
                          _buildInputLabel("ยืนยันรหัสผ่าน"),
                          _buildTextField(
                            hint: "กรอกรหัสผ่านของคุณ",
                            icon: Icons.lock_outline,
                            isPassword: true,
                            controller: newConfirmPasswordController,
                            eyeIndex: 1,
                          ),
                          const SizedBox(height: 40),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => RePassword(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "บันทึก",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
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
