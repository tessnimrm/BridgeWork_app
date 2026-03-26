import 'package:flutter/material.dart';
import '../widgets/background.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/categories.dart';
import '../widgets/cards.dart';
import '../WorkerScreen/main_pagework.dart';
/*
class Hire extends StatefulWidget {
  final String name;
  const Hire({super.key, required this.name});
  @override
  State<Hire> createState() => _HireState();
}

class _HireState extends State<Hire> {
  @override
  Widget build(ctx) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: GradientBackground(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 17),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(width: 20),
                          BackButton(),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                " ${widget.name} ",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Text(
                                "That's Hire mode",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: const Color.fromARGB(
                                    255,
                                    103,
                                    101,
                                    101,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 100),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: const Color.fromARGB(
                              255,
                              87,
                              85,
                              90,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Container(
                        height: 48,
                        width: 340,
                        padding: EdgeInsets.only(top: 6),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(188, 194, 194, 194),
                          boxShadow: [],
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: TextField(
                          style: TextStyle(color: Colors.black, fontSize: 14),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                            hintStyle: TextStyle(
                              color: const Color.fromARGB(255, 77, 76, 76),
                              fontSize: 20,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: const Color.fromARGB(255, 134, 132, 132),
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 10,
                          children: <Widget>[
                            SizedBox(width: 10),
                            Categories(text: "All", icon: Icon(Icons.android)),
                            Categories(
                              text: "tech and digital",
                              icon: Icon(Icons.android),
                            ),
                            Categories(
                              text: "idk what",
                              icon: Icon(Icons.android),
                            ),
                            Categories(
                              text: "hello",
                              icon: Icon(Icons.android),
                            ),
                            Categories(
                              text: "bilama",
                              icon: Icon(Icons.android),
                            ),
                            Categories(
                              text: "hello",
                              icon: Icon(Icons.android),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Wrap(
                        runSpacing: 15,
                        children: [
                          Cards(
                            textt: "name",
                            avatar: NetworkImage(
                              "	https://i.pinimg.com/736x/c1/ec/37/c1ec37f6e663304eecdf8cf0f9b0c116.jpg",
                            ),
                            place: "cafeteria",
                            timing: "morning",
                            flixebility: "flexible",
                          ),
                          Cards(
                            textt: "name",
                            avatar: NetworkImage(
                              "	https://i.pinimg.com/736x/c1/ec/37/c1ec37f6e663304eecdf8cf0f9b0c116.jpg",
                            ),
                            place: "cafeteria",
                            timing: "morning",
                            flixebility: "flexible",
                          ),
                          Cards(
                            textt: "name",
                            avatar: NetworkImage(
                              "	https://i.pinimg.com/736x/c1/ec/37/c1ec37f6e663304eecdf8cf0f9b0c116.jpg",
                            ),
                            place: "cafeteria",
                            timing: "morning",
                            flixebility: "flexible",
                          ),
                          Cards(
                            textt: "name",
                            avatar: NetworkImage(
                              "	https://i.pinimg.com/736x/c1/ec/37/c1ec37f6e663304eecdf8cf0f9b0c116.jpg",
                            ),
                            place: "cafeteria",
                            timing: "morning",
                            flixebility: "flexible",
                          ),
                          SizedBox(height: 27),
                        ],
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30, // distance from bottom
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Work()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 114, 110, 202),
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                ),
                child: Text(
                  "Switch to Work mode",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/