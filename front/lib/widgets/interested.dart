import 'package:flutter/material.dart';

class Interested extends StatefulWidget {
  const Interested({super.key});

  @override
  State<Interested> createState() => _InterestedState();
}

class _InterestedState extends State<Interested> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        width: 100,
        height: 25,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Color.fromARGB(255, 109, 54, 206) : Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 153, 153, 153),
              blurRadius: 4, // how soft the shadow is
              spreadRadius: 1, // how much it spreads
              offset: const Offset(2, 2), // position of shadow
            ),
          ],
        ),
        child: Text(
          "interested",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 10,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
