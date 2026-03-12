import 'package:cinema/cinemascreen.dart';
import 'package:flutter/material.dart';
import 'package:cinema/showtimepage/home.dart';
import 'package:cinema/moviescreen.dart';
import 'package:cinema/customeraccount.dart';
import 'package:cinema/historyon.dart';
import 'package:cinema/howtopay.dart';
import 'package:cinema/data/user.dart'; // เพิ่ม import เพื่อเรียกใช้ UserSessionData

class TopBar extends StatefulWidget {
  final int selectedIndex;

  const TopBar({super.key, required this.selectedIndex});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  OverlayEntry? _overlayEntry;
  bool isSettingOpen = false;

  void _navigate(int index) {
    if (index == widget.selectedIndex) return;
    _closeMenu();
    Widget page;
    if (index == 0) {
      page = const MovieHomePage();
    } else if (index == 1) {
      page = const MovieScreen();
    } else {
      page = const CinemaScreen();
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  void _openMenu() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          // Backdrop
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeMenu,
              child: Container(color: Colors.black.withOpacity(0.5)),
            ),
          ),
          // Dropdown
          Positioned(
            top: position.dy + size.height + 4,
            right: 16,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 280,
                decoration: BoxDecoration(
                  color: const Color(0xFF262626),
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
                            onPressed: _closeMenu,
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.white24, height: 1),

                    _buildMenuItem(
                      icon: Icons.person_outline,
                      title: "จัดการบัญชี",
                      textColor: Colors.white,
                      onTap: () {
                        setState(() => isSettingOpen = false);
                        _closeMenu(); // ปิดเมนูก่อนเปลี่ยนหน้า
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const AccountManagementScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.confirmation_number_outlined,
                      title: "ประวัติการซื้อตั๋ว",
                      textColor: Colors.white,
                      onTap: () {
                        setState(() => isSettingOpen = false);
                        _closeMenu();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TicketHistoryScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.credit_card_outlined,
                      title: "วิธีการชำระเงิน",
                      textColor: Colors.white,
                      onTap: () {
                        setState(() => isSettingOpen = false);
                        _closeMenu();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentMethodScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.logout,
                      title: "ออกจากระบบ",
                      textColor: Colors.redAccent,
                      onTap: () {
                        setState(() => isSettingOpen = false);
                        _closeMenu(); // พับเมนูเก็บ

                        // 1. ล้างข้อมูลเซสชั่นผู้ใช้ปัจจุบันออก
                        UserSessionData.name = '';
                        UserSessionData.lastname = '';
                        UserSessionData.email = '';
                        UserSessionData.password = '';

                        // 2. เคลียร์ประวัติหน้าจอ (Stack) ทั้งหมดแล้วพาไปหน้าล็อกอิน
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login',
                          (route) => false,
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(_overlayEntry!);
    if (mounted) setState(() => isSettingOpen = true);
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) setState(() => isSettingOpen = false);
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> menus = ["หน้าแรก", "ภาพยนตร์", "โรงภาพยนตร์"];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ── Menu items ──
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(menus.length, (index) {
                bool isSelected = widget.selectedIndex == index;
                return GestureDetector(
                  onTap: () => _navigate(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      border: isSelected
                          ? Border.all(color: Colors.white)
                          : null,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      menus[index],
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected ? Colors.white : Colors.white60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          // ── Hamburger icon (ไม่เปลี่ยนเป็น close) ──
          GestureDetector(
            onTap: () => isSettingOpen ? _closeMenu() : _openMenu(),
            child: const Icon(Icons.menu, color: Colors.red, size: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: textColor, size: 22),
            const SizedBox(width: 14),
            Text(title, style: TextStyle(color: textColor, fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
