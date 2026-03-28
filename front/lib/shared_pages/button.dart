import 'package:flutter/material.dart';

class Botton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Function()? onPressed;
  
  const Botton({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor = Colors.black,
  });
  
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 320,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(79, 70, 229, 1),
              Color.fromRGBO(131, 125, 225, 1),
              Color.fromRGBO(217, 217, 217, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
            ),
          ),
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
    );
  }
}