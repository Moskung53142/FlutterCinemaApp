import 'package:flutter/material.dart';
class ShowtimeAppbar extends StatelessWidget {
  const ShowtimeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          
          onPressed: null,
          child: Image.asset(
            "asset/image/Vector.png",
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Text("เลือกรอบฉาย", style: TextStyle(color: Colors.white , fontSize: 12)),
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.white,
                  width: 2
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Text("เลือกรอบฉาย", style: TextStyle(color: Colors.white , fontSize: 12)),
            ),
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.white,
                  width: 2
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Text("เลือกรอบฉาย", style: TextStyle(color: Colors.white , fontSize: 12)),
            ),
            
          ],
        ),
      ],
    );
  }
}