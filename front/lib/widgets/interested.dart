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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 100,
        height: 25,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              isSelected = !isSelected;
            });
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(0, 25),
            padding: EdgeInsets.zero,
            backgroundColor: isSelected
                ? Color.fromARGB(255, 109, 54, 206)
                : Color(0xFFD9D9D9),
            elevation: 7,
            shadowColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
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
      ),
    );
  }
}
