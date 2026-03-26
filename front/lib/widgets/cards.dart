// widgets/cards.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'categoriescards.dart';

class Cards extends StatefulWidget {
  final String textt;
  final String place;
  final ImageProvider? avatar;
  final String timing;
  final String flixebility;
  final bool isLiked;
  final VoidCallback onLikePressed;
  final VoidCallback? onTap;
  final VoidCallback? onInterestedPressed;

  const Cards({
    super.key,
    required this.textt,
    this.avatar,
    required this.place,
    required this.timing,
    required this.flixebility,
    this.isLiked = false,
    required this.onLikePressed,
    this.onTap,
    this.onInterestedPressed,
  });

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color: Colors.white,
        elevation: 7,
        shadowColor: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 317,
          height: 150,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (widget.avatar != null)
                    CircleAvatar(radius: 20, backgroundImage: widget.avatar)
                  else
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Color.fromARGB(255, 123, 61, 171),
                      child: Icon(Icons.person, color: Colors.white, size: 20),
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.textt,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          widget.place,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            height: 1,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      widget.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: widget.isLiked ? Colors.red : Colors.grey,
                      size: 25,
                    ),
                    onPressed: widget.onLikePressed,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Categories(text: "figma", onPressed: null),
                  const SizedBox(width: 10),
                  const Categories(text: "flutter", onPressed: null),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Icon(
                    Icons.access_time,
                    color: Color.fromARGB(211, 0, 0, 0),
                  ),
                  Text(
                    widget.timing,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Text("."),
                  Text(
                    widget.flixebility,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTap: widget.onInterestedPressed,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: HexColor("#837DE1"),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Interested",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
