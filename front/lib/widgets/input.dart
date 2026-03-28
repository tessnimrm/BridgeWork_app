import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String text;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType; // ✅ أضف هذا

  const Input({
    super.key,
    required this.text,
    this.obscureText = false,
    this.controller,
    this.keyboardType, // ✅ أضف هذا
  });
  @override
  Widget build(ctx) {
    return SizedBox(
      width: 320,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,

        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(color: const Color.fromARGB(255, 129, 124, 124)),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 211, 214, 219)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
