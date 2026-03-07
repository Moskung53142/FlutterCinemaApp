import 'package:flutter/material.dart';

class Theatertype extends StatefulWidget {
  const Theatertype({super.key});

  @override
  State<Theatertype> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Theatertype> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white
            ),
            onPressed: () {
              
            },
            child: Text("ทั้งหมด", style: TextStyle(color: Colors.white)),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white
            ),
            onPressed: () {
              
            },
            child: Text("IMAX", style: TextStyle(color: Colors.white)),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white
            ),
            onPressed: () {
              
            },
            child: Text("4DX", style: TextStyle(color: Colors.white)),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white
            ),
            onPressed: () {
              
            },
            child: Text("Kids", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
