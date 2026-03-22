import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const Categories({
    super.key,
    required this.text,
    required this.onPressed,
  });
  @override
  Widget build(ctx) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: Size(0, 19),
            padding: EdgeInsets.symmetric(horizontal: 20),
            backgroundColor: Color.fromARGB(255, 217, 217, 217),
            shadowColor: Colors.transparent,
            overlayColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 60, 60, 60),
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}
