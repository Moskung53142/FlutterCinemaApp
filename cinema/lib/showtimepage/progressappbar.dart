import 'package:flutter/material.dart';

class ShowtimeAppbar extends StatelessWidget {
  const ShowtimeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors
                .transparent, // Make background invisible to match typical app bars
            shadowColor: Colors.transparent, // Remove button shadow
            padding: const EdgeInsets.all(8),
          ),
          // CHANGED: Check if we can go back before popping
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: const Text(
                "เลือกรอบฉาย",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: const Text(
                "เลือกที่นั่ง",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: const Text(
                "ชำระเงิน",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
