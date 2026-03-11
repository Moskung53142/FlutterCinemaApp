import 'package:flutter/material.dart';
import 'data/user.dart'; // สำคัญ: นำเข้าไฟล์ user.dart เพื่อดึงข้อมูลชื่อ

class AddCardPayScreen extends StatefulWidget {
  const AddCardPayScreen({super.key});

  @override
  State<AddCardPayScreen> createState() => _AddCardPayScreenState();
}

class _AddCardPayScreenState extends State<AddCardPayScreen> {
  late TextEditingController _cardNameController; // เปลี่ยนเป็น late เพื่อรับค่าเริ่มต้น
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  
  bool _isPrimaryCard = true;

  @override
  void initState() {
    super.initState();
    // ดึงชื่อและนามสกุลจาก userListData[0] มาเป็นค่าเริ่มต้นในช่องชื่อบนบัตร
    String fullName = "${userListData[0].name} ${userListData[0].lastname}";
    _cardNameController = TextEditingController(text: fullName);
  }

  @override
  void dispose() {
    _cardNameController.dispose();
    _cardNumberController.dispose();
    _expController.dispose();
    _cvvController.dispose();
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
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'เพิ่มบัตรเครดิต/เดบิต',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ส่วนหัว: ผู้ให้บริการ (Payment Method)
              Center(
                child: Column(
                  children: [
                    const Text(
                      'ผู้ให้บริการ (Payment Method)',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildProviderLogo('asset/image/mastercard.png'),
                        const SizedBox(width: 8),
                        _buildProviderLogo('asset/image/visa.webp'),
                        const SizedBox(width: 8),
                        _buildProviderLogo('asset/image/americanexpress.png'),
                        const SizedBox(width: 8),
                        _buildProviderLogo('asset/image/unionpay.png'),
                        const SizedBox(width: 8),
                        _buildProviderLogo('asset/image/paypal.png'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              const Text('ข้อมูลบนบัตร', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // ช่องชื่อบนบัตร จะมีข้อมูลชื่อนามสกุลจาก user.dart โชว์ขึ้นมาให้เลย
              _buildContactRow('ชื่อบนบัตร :', 'Name on card', _cardNameController),
              const SizedBox(height: 12),
              _buildContactRow('หมายเลขบัตร :', '0000 0000 0000 0000', _cardNumberController),
              const SizedBox(height: 12),
              
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        const Text('หมดอายุ :', style: TextStyle(color: Colors.white, fontSize: 12)),
                        Expanded(child: _buildInputBox('ดด/ปป', _expController)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        const Text('CVV :', style: TextStyle(color: Colors.white, fontSize: 12)),
                        Expanded(child: _buildInputBox('***', _cvvController)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Checkbox: บันทึกให้เป็นบัตรหลัก
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: _isPrimaryCard,
                      onChanged: (bool? value) {
                        setState(() {
                          _isPrimaryCard = value ?? true;
                        });
                      },
                      activeColor: const Color(0xFFE50914),
                      checkColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('บันทึกให้เป็นบัตรหลัก', style: TextStyle(color: Colors.white, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 24),

              // ปุ่ม: บันทึกข้อมูล
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    final newCardData = {
                      'cardName': _cardNameController.text,
                      'cardNumber': _cardNumberController.text,
                      'expiryDate': _expController.text,
                      'cvv': _cvvController.text,
                      'isPrimary': _isPrimaryCard,
                    };
                    Navigator.pop(context, newCardData);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE50914),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'บันทึกข้อมูล',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Widget สำหรับสร้างกล่องโลโก้ผู้ให้บริการ
  Widget _buildProviderLogo(String imagePath) {
    return Container(
      height: 28, // ความสูงของโลโก้
      width: 44,  // ความกว้างของโลโก้
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white, // พื้นหลังสีขาวให้โลโก้เด่นขึ้น
        borderRadius: BorderRadius.circular(4),
      ),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain, // จัดให้รูปพอดีกับกรอบ
      ),
    );
  }

  Widget _buildContactRow(String label, String hint, TextEditingController controller) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ),
        Expanded(child: _buildInputBox(hint, controller)),
      ],
    );
  }

  Widget _buildInputBox(String hint, TextEditingController controller) {
    return Container(
      height: 28,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.black, fontSize: 12),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 12),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          border: InputBorder.none,
        ),
      ),
    );
  }
}