import 'package:cinema/paymentselect.dart';
import 'package:flutter/material.dart';
import 'package:cinema/model/movie_list.dart';

class SeatUI extends StatefulWidget {
  final Map<String, dynamic> bookingData;

  const SeatUI({super.key, required this.bookingData});

  @override
  State<SeatUI> createState() => _SeatUIState();
}

class _SeatUIState extends State<SeatUI> {
  // List to store the seats the user clicks (e.g., ["D7", "D8"])
  List<String> selectedSeats = [];

  // Mocking booked seats so it matches your reference image (C3, C4 are taken)
  final List<String> bookedSeats = ["G6", "G7","G8"];

  // The rows for our cinema
  final List<String> rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];

  // Price per seat
  final int pricePerSeat = 160;

  void toggleSeat(String seatId) {
    if (bookedSeats.contains(seatId)) return; // Cannot select booked seats

    setState(() {
      if (selectedSeats.contains(seatId)) {
        selectedSeats.remove(seatId); // Deselect
      } else {
        selectedSeats.add(seatId); // Select
      }
      // Sort alphabetically so "D7, D8" looks neat
      selectedSeats.sort();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Safely fetch movie info. Default to index 0 if something goes wrong
    int mIndex = widget.bookingData['movie_index'] ?? 0;
    final movie = appMovieList[mIndex];

    return Column(
      children: [
        // ==========================================
        // 1. TOP SECTION: MOVIE INFO
        // ==========================================
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  movie.moviePic,
                  width: 80,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${movie.category} | ${movie.duration} นาที",
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      widget.bookingData['theaterName'] ??
                          widget.bookingData['cinema'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.bookingData['date'],
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Theatre ${widget.bookingData['screen']}  เวลา ${widget.bookingData['time']} น.",
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ==========================================
        // 2. LEGEND (Available, Booked, Selected)
        // ==========================================
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem(Colors.white, "ที่นั่งว่าง"),
            const SizedBox(width: 20),
            _buildLegendItem(Colors.white54, "ถูกจองแล้ว", isBooked: true),
            const SizedBox(width: 20),
            _buildLegendItem(const Color(0xFFF0B90B), "ที่นั่งที่เลือก"),
          ],
        ),

        const SizedBox(height: 20),

        // ==========================================
        // 3. THE "SCREEN" ARC AND SEAT GRID
        // ==========================================
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // The Red Screen Arc
                SizedBox(
                  height: 35,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        top: 15,
                        child: Container(
                          width: 320,
                          height: 50,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: Colors.red, width: 2),
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.elliptical(200, 25),
                              topRight: Radius.elliptical(200, 25),
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        "SCREEN",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Generating Rows A through H
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: rows.map((rowLabel) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Left Row Letter
                            SizedBox(
                              width: 20,
                              child: Text(
                                rowLabel,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            // 8 Seats in the middle
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(8, (colIndex) {
                                String seatId = "$rowLabel${colIndex + 1}";
                                bool isBooked = bookedSeats.contains(seatId);
                                bool isSelected = selectedSeats.contains(
                                  seatId,
                                );

                                return GestureDetector(
                                  onTap: () => toggleSeat(seatId),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFFF0B90B)
                                          : (isBooked
                                                ? Colors.white54
                                                : Colors.white),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: isBooked
                                        ? const Icon(
                                            Icons.close,
                                            color: Colors.black54,
                                            size: 22,
                                          )
                                        : null,
                                  ),
                                );
                              }),
                            ),

                            // Right Row Letter
                            SizedBox(
                              width: 20,
                              child: Text(
                                rowLabel,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),

        // ==========================================
        // 4. BOTTOM BAR (PRICE & CONTINUE BUTTON)
        // ==========================================
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          decoration: const BoxDecoration(
            color: Color(0xFF2C2C2C), // Dark grey bottom sheet
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align to top when multi-line
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "ที่นั่งที่เลือก",
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                        Text(
                          selectedSeats.isEmpty
                              ? "-"
                              : selectedSeats.join(", "),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ), // Gives breathing room before the price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "รวม",
                        style: TextStyle(color: Colors.white54, fontSize: 14),
                      ),
                      Text(
                        "฿${(selectedSeats.length * pricePerSeat).toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Color(0xFFF0B90B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: selectedSeats.isEmpty
                      ? null
                      : () {
                          // 1. MAKE A COPY OF THE OLD DATA AND ADD NEW DATA!
                          Map<String, dynamic> finalBookingData = Map.from(
                            widget.bookingData,
                          );

                          finalBookingData['selected_seats'] = selectedSeats;
                          finalBookingData['total_price'] =
                              selectedSeats.length * pricePerSeat;

                          // 2. PREPARE FOR NEXT PAGE
                          // When you build your payment/checkout page, UNCOMMENT this section:
                          
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Paymentselect(bookingData: finalBookingData),
                      ),
                    );
                    

                          
                          
                        },
                  child: const Text(
                    "ดำเนินการต่อ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Helper widget to build the legend items (Available, Booked, Selected)
  Widget _buildLegendItem(Color color, String text, {bool isBooked = false}) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: isBooked
              ? const Icon(Icons.close, color: Colors.black54, size: 16)
              : null,
        ),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
