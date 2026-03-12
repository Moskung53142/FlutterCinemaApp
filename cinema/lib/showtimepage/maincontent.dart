import 'package:cinema/model/movie_list.dart';
import 'package:cinema/showtimepage/horizondate.dart';
import 'package:cinema/showtimepage/theatertype.dart';
import 'package:flutter/material.dart';
import 'package:cinema/movie_info.dart';

class ShowTimeContent extends StatefulWidget {
  final int movieIndex; 
  final int userIndex; 

  const ShowTimeContent({super.key, this.movieIndex = 0, this.userIndex = 0});

  @override
  State<ShowTimeContent> createState() => _ShowTimeContentState();
}

class _ShowTimeContentState extends State<ShowTimeContent> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final movie = appMovieList[widget.movieIndex];

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.4),
          Container(
            color: const Color.fromARGB(209, 0, 0, 0),
            padding: const EdgeInsets.all(20), // ย้าย Padding มารวมที่ชั้นนอกสุด
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center, // จัดให้อยู่กึ่งกลางแนวตั้ง
              children: [
                
                // ใช้ Expanded ครอบส่วนของรายละเอียดหนัง ป้องกันการดันปุ่มด้านขวาตกขอบ
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        // Text จะขึ้นบรรทัดใหม่ให้อัตโนมัติเมื่ออยู่ภายใต้ Expanded
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${movie.category}  |  ${movie.duration} นาที",
                        style: const TextStyle(color: Colors.white70), // ลดแสงนิดหน่อยให้ดูสมูทขึ้น
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "วันที่เข้าฉาย : ${movie.startdate}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 15), // ระยะห่างระหว่างตัวหนังสือและปุ่ม
                
                // ปุ่มรายละเอียด
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.amber,
                    side: const BorderSide(color: Colors.amber, width: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieInfoScreen(
                          movieIndex: widget.movieIndex, 
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "รายละเอียด",
                    style: TextStyle(color: Colors.amber),
                  ),
                ),
              ],
            ),
          ),
          
          // ไม่จำเป็นต้องเอา Container ว่างเปล่าครอบทับ
          HorizontalDatePicker(
            movieStartDate: movie.startdate, 
            onDateSelected: (newDate) {
              setState(() {
                selectedDate = newDate;
              });
            },
          ),
          
          Theatertype(
            movie: movie, 
            selectedDate: selectedDate,
            userIndex: widget.userIndex, 
          ),
        ],
      ),
    );
  }
}