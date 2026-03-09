import 'package:cinema/bankpayment.dart'; // Make sure this file exists!
import 'package:cinema/creditcard.dart'; // Make sure this file exists!
import 'package:flutter/material.dart';
import 'package:cinema/model/movie_list.dart';

class PaymentUI extends StatefulWidget {
  final Map<String, dynamic> bookingData;

  const PaymentUI({super.key, required this.bookingData});

  @override
  State<PaymentUI> createState() => _PaymentUIState();
}

class _PaymentUIState extends State<PaymentUI> {
  // 0 = Credit/Debit Card, 1 = Bank Transfer
  int selectedPaymentMethod = 0;

  @override
  Widget build(BuildContext context) {
    // Safely fetch movie info
    int mIndex = widget.bookingData['movie_index'] ?? 0;
    final movie = appMovieList[mIndex];

    // Safely fetch seats and price
    List<String> seats = List<String>.from(
      widget.bookingData['selected_seats'] ?? [],
    );
    double totalPrice = (widget.bookingData['total_price'] ?? 0).toDouble();

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==========================================
                  // 1. TOP SECTION: MOVIE INFO
                  // ==========================================
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          movie.moviePic,
                          width: 90,
                          height: 130,
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
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "${movie.category} | ${movie.duration} นาที",
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              widget.bookingData['theaterName'] ??
                                  widget.bookingData['cinema'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.bookingData['date'],
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "Theatre ${widget.bookingData['screen']}  เวลา ${widget.bookingData['time']} น.",
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // ==========================================
                  // 2. SEAT & PRICE SUMMARY BOX
                  // ==========================================
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white24, width: 1.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "ที่นั่งที่เลือก",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                seats.isEmpty ? "-" : seats.join(", "),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "รวม",
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${totalPrice.toStringAsFixed(2)} บาท",
                              style: const TextStyle(
                                color: Color(0xFFF0B90B),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ==========================================
                  // 3. PAYMENT METHODS
                  // ==========================================
                  const Text(
                    "ช่องทางชำระเงิน",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      _buildPaymentMethodCard(
                        index: 0,
                        icon: Icons.credit_card,
                        label: "เครดิตการ์ด/\nเดบิตการ์ด",
                      ),
                      const SizedBox(width: 15),
                      _buildPaymentMethodCard(
                        index: 1,
                        icon: Icons.account_balance,
                        label: "บัญชีเงินฝาก",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // ==========================================
        // 4. BOTTOM BAR (PAY BUTTON)
        // ==========================================
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          decoration: const BoxDecoration(
            color: Color(0xFF2C2C2C), // Dark grey bottom sheet
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                if (selectedPaymentMethod == 0) {
                  // Navigate to Credit Card Screen (Ensure class is named CreditCardPaymentScreen in creditcard.dart)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreditCardPaymentScreen(
                        bookingData:
                            widget.bookingData, // Pass EVERYTHING forward
                      ),
                    ),
                  );
                } else if (selectedPaymentMethod == 1) {
                  // Navigate to Bank Transfer Screen (Ensure class is named BankTransferPaymentScreen in bankpayment.dart)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BankTransferPaymentScreen(
                        bookingData:
                            widget.bookingData, // Pass EVERYTHING forward
                      ),
                    ),
                  );
                }
              },
              child: const Text(
                "ชำระเงิน",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper widget to build the payment selection cards
  Widget _buildPaymentMethodCard({
    required int index,
    required IconData icon,
    required String label,
  }) {
    bool isSelected = selectedPaymentMethod == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = index;
        });
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.red : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            index == 1
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.account_balance,
                        color: Colors.white,
                        size: 30,
                      ),
                      Icon(Icons.add, color: Colors.white, size: 16),
                    ],
                  )
                : Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
