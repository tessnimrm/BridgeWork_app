import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'categoriescards.dart';
import 'interested.dart';

class Cards extends StatefulWidget {
  final String textt;
  final String place;
  final ImageProvider? avatar;
  final String timing;
  final String flixebility;
  const Cards({
    super.key,
    required this.textt,
    this.avatar,
    required this.place,
    required this.timing,
    required this.flixebility,
  });

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  bool isSaved = false;
  @override
  Widget build(ctx) {
    return Card(
      color: Colors.white,
      elevation: 7,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 317,
        height: 143,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Avatar
                if (widget.avatar != null)
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: widget.avatar, // <-- user image
                  )
                else
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromARGB(255, 123, 61, 171),
                    child: Icon(Icons.person, color: Colors.white, size: 20),
                  ),
                SizedBox(width: 10),
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
                        overflow: TextOverflow
                            .ellipsis, // optional: prevents overflow
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
                    isSaved ? Icons.favorite : Icons.favorite_border,
                    color: isSaved ? Colors.red : Colors.grey,
                    size: 25,
                  ),
                  onPressed: () {
                    setState(() {
                      isSaved = !isSaved;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Categories(text: "figma", onPressed: () {}),
                SizedBox(width: 10),
                Categories(text: "flutter", onPressed: () {}),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(
                  Icons.access_time,
                  color: const Color.fromARGB(211, 0, 0, 0),
                ),
                Text(
                  widget.timing,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text("."),
                Text(
                  widget.flixebility,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 30),
                Interested(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
