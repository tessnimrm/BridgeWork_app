import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child; 

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: const [
            Color.fromARGB(255, 215, 219, 225),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          // Optional: Add stops based on screen height
          stops: [0.0, screenHeight > 800 ? 0.7 : 0.5],
        ),
      ),
      child: child, 
    );
  }
}