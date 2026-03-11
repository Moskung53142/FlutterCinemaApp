import 'package:flutter/material.dart';
import 'historyon.dart'; // import หน้ากำลังจะฉาย
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
      home: TicketHistoryFinishedScreen(),
    );
  }
}

class TicketHistoryFinishedScreen extends StatelessWidget {
  const TicketHistoryFinishedScreen({super.key});

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
            // กลับไปที่หน้า home.dart
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MovieHomePage()),
              (route) => false,
            );
          },
        ),
        title: const Text(
          'ประวัติการซื้อตั๋ว',
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
          children: [
            Center(
              child: Container(
                width: 220,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0), 
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    // ทำให้ปุ่ม 'กำลังจะฉาย' กดได้
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // เปลี่ยนกลับไปหน้า historyon.dart แบบแทนที่หน้าเดิม
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const TicketHistoryScreen()),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'กำลังจะฉาย',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE50914), 
                          borderRadius: BorderRadius.circular(18),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'จบแล้ว',
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
            ),
            const SizedBox(height: 24),

            // การ์ดตั๋วหนัง (เหมือนเดิม)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.white30, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: SizedBox(
                          width: 80,
                          height: 120,
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg', 
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(color: Colors.grey[800]),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'อวตาร',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE0E0E0), 
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'ชมแล้ว',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'รัชโยธิน ซีนีเพล็กซ์',
                              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            const Text('Theatre 6', style: TextStyle(color: Colors.white70, fontSize: 12)),
                            const SizedBox(height: 2),
                            const Text('29 ม.ค. 2569  เวลา 20:00 น.', style: TextStyle(color: Colors.white70, fontSize: 12)),
                            const SizedBox(height: 2),
                            const Text('ราคาตั๋ว 160 บาท', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('เลขที่นั่ง : E8', style: TextStyle(color: Color(0xFFE2B93B), fontSize: 12)),
                      Text('วันที่ซื้อ : 27 ม.ค. 2569', style: TextStyle(color: Color(0xFFE2B93B), fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text('ซื้อโดย : สมชาย หลังอาน', style: TextStyle(color: Color(0xFFE2B93B), fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}