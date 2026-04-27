import 'package:flutter/material.dart';

class DateDivider extends StatelessWidget {
  final String label;

  const DateDivider({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFD9F4E4),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Color(0x14000000), blurRadius: 1, offset: Offset(0, 1)),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF54656F),
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
