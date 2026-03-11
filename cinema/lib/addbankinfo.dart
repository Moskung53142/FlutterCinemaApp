import 'package:flutter/material.dart';
import 'data/user.dart'; // สำคัญ: นำเข้าไฟล์ user.dart เพื่อดึงข้อมูลชื่อ

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BankAccountDetailScreen(),
    );
  }
}

class BankAccountDetailScreen extends StatefulWidget {
  const BankAccountDetailScreen({super.key});

  @override
  State<BankAccountDetailScreen> createState() => _BankAccountDetailScreenState();
}

class _BankAccountDetailScreenState extends State<BankAccountDetailScreen> {
  final TextEditingController _accountNumberController = TextEditingController();

  // ดึงชื่อและนามสกุลจาก userListData[0] มาต่อกัน
  final String currentUserName = "${userListData[0].name} ${userListData[0].lastname}";
  
  // ตัวแปรเก็บเลขบัญชีที่จะแสดงบนบัตร (เริ่มต้นเป็นดอกจันทั้งหมด)
  String _displayCardNumber = "**** **** **** ****";

  @override
  void dispose() {
    _accountNumberController.dispose();
    super.dispose();
  }

  // ฟังก์ชันอัปเดตตัวเลขบนบัตรแบบเรียลไทม์
  void _updateCardNumber(String input) {
    // ลบช่องว่างหรือตัวอักษรอื่นออกให้เหลือแต่ตัวเลข
    String rawNumber = input.replaceAll(RegExp(r'\D'), '');
    
    // เติม * ให้ครบ 16 ตัวอักษร
    String padded = rawNumber.padRight(16, '*');
    
    setState(() {
      // จัดฟอร์แมตเว้นวรรคทุกๆ 4 ตัวอักษร
      _displayCardNumber = '${padded.substring(0, 4)} ${padded.substring(4, 8)} ${padded.substring(8, 12)} ${padded.substring(12, 16)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // พื้นหลังสีดำคุมธีม
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () {
            // กดกลับเฉยๆ จะไม่ส่งข้อมูลอะไรกลับไป (ไม่บันทึก)
            Navigator.pop(context); 
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // 1. ส่วนของการ์ดจำลอง
            // ==========================================
            Container(
              width: double.infinity,
              height: 200, 
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF141414), 
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24, width: 1), 
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'KBank',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Image.asset(
                              'asset/image/kbank.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'asset/image/mastercard.png',
                        width: 40,
                      ),
                    ],
                  ),
                  // แถวกลาง: หมายเลขบัตร/บัญชีที่เปลี่ยนตามการพิมพ์
                  Text(
                    _displayCardNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 2.0, 
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Card Holder', style: TextStyle(color: Colors.white54, fontSize: 10)),
                          const SizedBox(height: 2),
                          Text(currentUserName, style: const TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Expires', style: TextStyle(color: Colors.white54, fontSize: 10)),
                          SizedBox(height: 2),
                          Text('09/25', style: TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // ==========================================
            // 2. ส่วนกรอกเลขที่บัญชี
            // ==========================================
            const Text(
              'เลขที่บัญชีธนาคาร',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // กล่องพิมพ์
            Container(
              height: 32, 
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextField(
                controller: _accountNumberController,
                keyboardType: TextInputType.number, 
                maxLength: 16, // จำกัดให้พิมพ์ได้แค่ 16 ตัว
                onChanged: _updateCardNumber, // เรียกฟังก์ชันเมื่อมีการพิมพ์
                style: const TextStyle(color: Colors.black, fontSize: 12),
                decoration: InputDecoration(
                  hintText: 'ใส่เลขที่บัญชีธนาคารของคุณ',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 12),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  border: InputBorder.none,
                  counterText: "", // ซ่อนตัวนับจำนวนตัวอักษรด้านล่าง
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ==========================================
            // 3. ปุ่มบันทึก (สีแดง จัดขวา)
            // ==========================================
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  // เช็คว่าพิมพ์ข้อมูลหรือยัง
                  if (_accountNumberController.text.isNotEmpty) {
                    // ส่งข้อมูลเลขบัญชีกลับไปหน้าก่อนหน้า
                    Navigator.pop(context, _accountNumberController.text);
                  } else {
                    // ถ้ายังไม่พิมพ์อะไรเลย แจ้งเตือนเล็กน้อย
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('กรุณากรอกเลขที่บัญชีก่อนบันทึก')),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE50914), 
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
            ),
          ],
        ),
      ),
    );
  }
}