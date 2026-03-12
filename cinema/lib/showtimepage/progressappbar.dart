import 'package:flutter/material.dart';

class ShowtimeAppbar extends StatelessWidget {
  const ShowtimeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // Make background invisible
            shadowColor: Colors.transparent, // Remove button shadow
            padding: const EdgeInsets.all(8),
            minimumSize: Size.zero, // ลดระยะขอบปุ่มที่เกินจำเป็นออก
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context); // Go back to the previous page
            }
          },
          child: Image.asset(
            "asset/image/Vector.png",
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        
        // ใช้ Expanded เพื่อจำกัดความกว้างที่เหลือไม่ให้ดันจนตกขอบจอ
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStep("เลือกรอบฉาย", isActive: true),
              _buildStep("เลือกที่นั่ง", isActive: false),
              _buildStep("ชำระเงิน", isActive: false),
            ],
          ),
        ),
      ],
    );
  }

  // ฟังก์ชันช่วยสร้างกล่องสถานะแบบยืดหยุ่น (Flexible)
  Widget _buildStep(String text, {required bool isActive}) {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        decoration: BoxDecoration(
          color: isActive ? Colors.red : Colors.transparent,
          border: Border.all(
            color: isActive ? Colors.red : Colors.white, 
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 11),
          maxLines: 1,
          overflow: TextOverflow.ellipsis, // ป้องกันตัวหนังสือล้นกล่อง
        ),
      ),
    );
  }
}