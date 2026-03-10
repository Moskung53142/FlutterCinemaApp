import 'package:flutter/material.dart';
import 'package:cinema/model/movie_list.dart';
import 'package:cinema/data/user.dart';

// เปลี่ยนหน้าใน dropdown 366,375,384

// ปุ่มเปลี่ยนหน้า appBar 282, 305, 328

class MovieHomePage extends StatefulWidget {
  const MovieHomePage({super.key});

  @override
  State<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends State<MovieHomePage> {
  bool isNowShowing = true;
  bool isSettingOpen = false;

  // ฟังก์ชันออกจากระบบ
  void Logout(BuildContext context) {
    UserSessionData.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // พื้นหลังหลักของแอป
      body: Stack(
        children: [
          // --- 1. เนื้อหาหลัก (อยู่ล่างสุด) ---
          SingleChildScrollView(
            child: Column(
              children: [
                // HERO BANNER SECTION
                Stack(
                  children: [
                    Container(
                      height: 450,
                      width: double.infinity,
                      color: Colors.grey[900],
                      child: Image.asset(
                        'asset/image/avatar-fire-and-ash.webp',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 450,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                            Colors.black,
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "อวตาร",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            "แฟนตาซี | 195 นาที",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "รายละเอียดภาพยนตร์ >",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text(
                                  "จองตั๋ว",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // SEARCH BAR
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "ค้นหาภาพยนตร์...",
                      hintStyle: const TextStyle(color: Colors.grey),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: const Icon(Icons.search, color: Colors.red),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const Text(
                  "ภาพยนตร์",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),

                // TAB SELECTOR
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => isNowShowing = true),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isNowShowing
                                  ? Colors.red
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "กำลังฉาย",
                              style: TextStyle(
                                color: isNowShowing
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => isNowShowing = false),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: !isNowShowing
                                  ? Colors.red
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "โปรแกรมหน้า",
                              style: TextStyle(
                                color: !isNowShowing
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // MOVIE GRID
                GridView.builder(
                  padding: const EdgeInsets.all(32),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: appMovieList.length > 4 ? 4 : appMovieList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    final movie = appMovieList[index];
                    return GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/home/movie/moviedetail',
                        arguments: {'movieIndex': index, 'userIndex': 0},
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  movie.moviePic,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "วันที่เข้าฉาย: ${movie.startdate}",
                            style: const TextStyle(
                              color: Colors.yellow,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            movie.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 100), // เผื่อที่ไว้ให้ Scroll พ้นขอบล่าง
              ],
            ),
          ),

          // --- 2. ตัวดักจับการจิ้มข้างนอกเพื่อปิดเมนู (Backdrop) ---
          if (isSettingOpen)
            GestureDetector(
              onTap: () => setState(() => isSettingOpen = false),
              child: Container(
                color: Colors.black.withOpacity(0.5), // พื้นหลังมืดลง 50%
                width: double.infinity,
                height: double.infinity,
              ),
            ),

          // --- 3. Top Navbar (แสดง หน้าแรก, ภาพยนตร์, ปุ่มเมนู) ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 10, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white70, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "หน้าแรก",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/theater');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white70, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "ภาพยนตร์",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/cinema');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white70, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "โรงภาพยนตร์",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isSettingOpen ? Icons.close : Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        isSettingOpen = !isSettingOpen;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          // --- 4. ตัว Dropdown Menu (แสดงเมื่อ isSettingOpen เป็น true) ---
          if (isSettingOpen)
            Positioned(
              top: 100, // ปรับตำแหน่งให้เหมาะสมกับ Navbar
              right: 15,
              child: Container(
                width: 280,
                decoration: BoxDecoration(
                  color: const Color(0xFF262626), // สีเทาเข้มแบบ Netflix
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // เมนู Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "เมนู",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white70,
                            ),
                            onPressed: () =>
                                setState(() => isSettingOpen = false),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.white24, height: 1),

                    // รายการเมนู
                    _buildMenuItem(
                      icon: Icons.person_outline,
                      title: "จัดการบัญชี",
                      textColor: Colors.white,
                      onTap: () {
                        setState(() => isSettingOpen = false);
                        // Navigator.pushNamed(context, '/profile');
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.confirmation_number_outlined,
                      title: "ประวัติการซื้อตั๋ว",
                      textColor: Colors.white,
                      onTap: () {
                        setState(() => isSettingOpen = false);
                        // Navigator.pushNamed(context, '/้history');
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.credit_card_outlined,
                      title: "วิธีการชำระเงิน",
                      textColor: Colors.white,
                      onTap: () {
                        setState(() => isSettingOpen = false);
                        // Navigator.pushNamed(context, '/payment');
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.logout,
                      title: "ออกจากระบบ",
                      textColor: Colors.redAccent,
                      onTap: () {
                        setState(() => isSettingOpen = false);
                        Logout(context);
                      },
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Widget ตัวช่วยสร้างรายการในเมนู
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 15,
        child: Icon(
          icon,
          size: 18,
          color: const Color(0xFFFBC02D), // สีเหลืองทอง
        ),
      ),
      title: Text(title, style: TextStyle(color: textColor, fontSize: 14)),
      onTap: onTap,
    );
  }
}
