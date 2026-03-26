import 'dart:ui';

import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  final String text;
  final String? imagePath;
  const Categories({super.key, required this.text, this.imagePath});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 34,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              isSelected = !isSelected;
            });
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            backgroundColor: isSelected
                ? const Color.fromARGB(255, 153, 94, 230)
                : const Color.fromARGB(255, 207, 206, 206),
            shadowColor: Colors.transparent,
            overlayColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.imagePath != null) ...[
                Image.asset(widget.imagePath!, width: 20, height: 20),
                const SizedBox(width: 6),
              ],
              Text(
                widget.text,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
