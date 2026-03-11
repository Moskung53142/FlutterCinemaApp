import 'package:cinema/showtimepage/cinimadetail.dart';
import 'package:flutter/material.dart';
import 'package:cinema/model/theater.dart';
import 'package:cinema/showtimepage/topbar.dart'; 

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CinemaScreen(),
  ));
}

class CinemaScreen extends StatefulWidget {
  final int userIndex;
  const CinemaScreen({super.key, this.userIndex = 0});

  @override
  State<CinemaScreen> createState() => _CinemaScreenState();
}

class _CinemaScreenState extends State<CinemaScreen> {
  int selectedIndex = 0;
  final List<String> types = ["ทั้งหมด", "IMAX", "4DX", "Kids"];
  String searchText = "";
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String selectedType = types[selectedIndex];
    List<String> cinemaNames =
        (selectedType == "ทั้งหมด"
                ? thearterList
                : thearterList.where((t) => t.type == selectedType))
            .map((t) => t.theaterName)
            .toSet()
            .toList();

    cinemaNames = cinemaNames
        .where((name) => name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            TopBar(selectedIndex: 2), // เพิ่ม userIndex

            // SEARCH BAR
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: searchController,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "ค้นหาโรงภาพยนตร์",
                    suffixIcon: Icon(Icons.search, color: Colors.red),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            // FILTER TABS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(types.length, (index) {
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 9),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFEEB30B)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        types[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: isSelected ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            Container(height: 15),
            const Divider(color: Color.fromARGB(127, 127, 127, 127), height: 1),

            // CINEMA LIST
            Expanded(
              child: ListView.builder(
                itemCount: cinemaNames.length,
                itemBuilder: (context, index) {
                  final cinemaName = cinemaNames[index];
                  final theater = thearterList.firstWhere(
                    (t) =>
                        t.theaterName == cinemaName &&
                        (selectedType == "ทั้งหมด" || t.type == selectedType),
                  );

                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Cinemadetail(
                                theaterName: cinemaName,
                                userIndex: widget.userIndex,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 12),
                          child: Row(
                            children: [
                              const Icon(Icons.theaters_outlined,
                                  color: Colors.white, size: 36),
                              Container(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cinemaName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      "${theater.distance} กม.",
                                      style: const TextStyle(
                                        color: Color.fromRGBO(212, 211, 211, 1),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right,
                                  color: Colors.white54, size: 24),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                          color: Color.fromARGB(127, 127, 127, 127), height: 1),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}