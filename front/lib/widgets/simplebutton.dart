import 'package:flutter/material.dart';

class Bottonsimple extends StatelessWidget {
  final String text;
  final Color textColor;
  final VoidCallback onPressed;
  const Bottonsimple({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.black,
  });
  @override
  Widget build(ctx) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 320,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(320, 48),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            overlayColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Color.fromARGB(255, 211, 214, 219)),
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: textColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
