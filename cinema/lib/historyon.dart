import 'package:flutter/material.dart';
import 'historyend.dart'; // import หน้าจบแล้ว
import 'eticket.dart'; // import หน้า E-Ticket
import 'package:cinema/showtimepage/home.dart';

// ==========================================
// 1. สร้าง Class และ Global List สำหรับเก็บประวัติ
// ==========================================
class TicketRecord {
  final String movieTitle;
  final String moviePic;
  final String theaterName;
  final int screen;
  final String date;
  final String time;
  final int totalPrice;
  final List<String> seats;
  final String buyerName;
  final String purchaseDate;

  TicketRecord({
    required this.movieTitle,
    required this.moviePic,
    required this.theaterName,
    required this.screen,
    required this.date,
    required this.time,
    required this.totalPrice,
    required this.seats,
    required this.buyerName,
    required this.purchaseDate,
  });
}

// List ส่วนกลางที่ใช้เก็บข้อมูลตั๋วที่ซื้อสำเร็จ (กำลังจะฉาย)
List<TicketRecord> globalTicketHistory = [];
// List ส่วนกลางที่ใช้เก็บข้อมูลตั๋วที่ใช้แล้ว (จบแล้ว)
List<TicketRecord> globalFinishedTicketHistory = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TicketHistoryScreen(),
    );
  }
}

// เปลี่ยนเป็น StatefulWidget เพื่อให้สามารถลบข้อมูลและรีเฟรชหน้าจอได้
class TicketHistoryScreen extends StatefulWidget {
  const TicketHistoryScreen({super.key});

  @override
  State<TicketHistoryScreen> createState() => _TicketHistoryScreenState();
}

class _TicketHistoryScreenState extends State<TicketHistoryScreen> {
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
            // ปุ่มสลับ (Toggle Button): กำลังจะฉาย / จบแล้ว
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
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE50914),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'กำลังจะฉาย',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // เปลี่ยนไปหน้า historyend.dart
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TicketHistoryFinishedScreen(),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'จบแล้ว',
                            style: TextStyle(
                              color: Colors.black87,
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
            ),
            const SizedBox(height: 24),

            // ==========================================
            // 2. การ์ดตั๋วหนังแบบ Dynamic List
            // ==========================================
            Expanded(
              child: globalTicketHistory.isEmpty
                  ? const Center(
                      child: Text(
                        'ยังไม่มีประวัติการซื้อตั๋ว',
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: globalTicketHistory.length,
                      itemBuilder: (context, index) {
                        final ticket = globalTicketHistory[index];
                        return _buildTicketCard(context, ticket);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // สร้าง Widget ย่อยเพื่อประกอบหน้าตาของตั๋วทีละใบ
  Widget _buildTicketCard(BuildContext context, TicketRecord ticket) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
                  child: Image.asset(
                    ticket.moviePic,
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
                        Expanded(
                          child: Text(
                            ticket.movieTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // 1. ย้ายข้อมูลไปที่ลิสต์ "จบแล้ว"
                            globalFinishedTicketHistory.insert(0, ticket);

                            // 2. ลบออกจากลิสต์ปัจจุบันและรีเฟรชหน้าจอ
                            setState(() {
                              globalTicketHistory.remove(ticket);
                            });

                            // 3. ไปเปิดหน้า E-Ticket
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ETicketScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE50914),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'E-Ticket',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      ticket.theaterName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Theatre ${ticket.screen}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${ticket.date}  เวลา ${ticket.time} น.',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'ราคาตั๋ว ${ticket.totalPrice} บาท',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'เลขที่นั่ง : ${ticket.seats.join(", ")}',
                  style: const TextStyle(
                    color: Color(0xFFE2B93B),
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Text(
                'วันที่ซื้อ : ${ticket.purchaseDate}',
                style: const TextStyle(color: Color(0xFFE2B93B), fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'ซื้อโดย : ${ticket.buyerName}',
            style: const TextStyle(color: Color(0xFFE2B93B), fontSize: 12),
          ),
        ],
      ),
    );
  }
}
