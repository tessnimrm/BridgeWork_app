import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:brigdeWork_app/background.dart';

class Likedpage extends StatefulWidget {
  const Likedpage({super.key});

  @override
  State<Likedpage> createState() => _LikedpageState();
}

class _LikedpageState extends State<Likedpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(child: SizedBox.expand()),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 122,
                    decoration: BoxDecoration(
                      color: HexColor("#837DE1"),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 28,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                        const Text(
                          "Liked",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // المحتوى هنا
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
