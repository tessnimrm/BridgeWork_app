import 'package:flutter/material.dart';

class CategoriesCard extends StatelessWidget {
  final String text;
  final VoidCallback? onTap; 
  final Color backgroundColor;

  const CategoriesCard({
    super.key,
    required this.text,
    this.onTap,
    this.backgroundColor = const Color(0xFFD9D9D9),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 20, 
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 60, 60, 60),
          ),
        ),
      ),
    );
  }
}
