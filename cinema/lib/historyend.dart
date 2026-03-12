import 'package:flutter/material.dart';
import 'historyon.dart'; // import หน้ากำลังจะฉายเพื่อดึง globalFinishedTicketHistory
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
                      child: GestureDetector(
                        onTap: () {
                          // เปลี่ยนกลับไปหน้า historyon.dart
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TicketHistoryScreen(),
                            ),
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

            // ==========================================
            // 2. การ์ดตั๋วหนังที่ใช้แล้ว (Dynamic List)
            // ==========================================
            Expanded(
              child: globalFinishedTicketHistory.isEmpty
                  ? const Center(
                      child: Text(
                        'ไม่มีประวัติการชมภาพยนตร์',
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: globalFinishedTicketHistory.length,
                      itemBuilder: (context, index) {
                        final ticket = globalFinishedTicketHistory[index];
                        return _buildFinishedTicketCard(context, ticket);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // สร้าง Widget ย่อยสำหรับตั๋วที่ดูจบแล้ว (ป้ายจะเปลี่ยนเป็นคำว่า 'ชมแล้ว' แทน E-Ticket)
  Widget _buildFinishedTicketCard(BuildContext context, TicketRecord ticket) {
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
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
