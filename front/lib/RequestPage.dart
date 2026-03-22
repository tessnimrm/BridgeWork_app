import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:brigdeWork_app/background.dart';

class Requestpage extends StatefulWidget {
  const Requestpage({super.key});

  @override
  State<Requestpage> createState() => _RequestpageState();
}

class _RequestpageState extends State<Requestpage> {
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
                          "Request",
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
                    child: Column(children: [
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
