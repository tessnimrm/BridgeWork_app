import 'package:flutter/material.dart';

class Botton extends StatelessWidget {
  final String text;
  final Color textColor;
<<<<<<< HEAD
  final VoidCallback onPressed;
  const Botton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.black,
  });
  @override
  Widget build(ctx) {
=======
  final Function()? onPressed;
  
  const Botton({
    super.key,
    required this.text,
    this.onPressed,
    this.textColor = Colors.black,
  });
  
  @override
  Widget build(BuildContext context) {
>>>>>>> 73a543805272cc2a4e16979fa554c315ed8b6cdc
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 320,
<<<<<<< HEAD
        decoration: BoxDecoration(
=======
        decoration: const BoxDecoration(
>>>>>>> 73a543805272cc2a4e16979fa554c315ed8b6cdc
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
<<<<<<< HEAD
          child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: textColor,
                fontSize: 16,
              ),
=======
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: textColor,
              fontSize: 16,
>>>>>>> 73a543805272cc2a4e16979fa554c315ed8b6cdc
            ),
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 73a543805272cc2a4e16979fa554c315ed8b6cdc
