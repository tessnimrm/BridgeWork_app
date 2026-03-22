import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  final String text;
  final Icon? icon;
  const Categories({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  State<Categories> createState() => _CategoriesState();
}
class _CategoriesState extends State<Categories> {
    bool isSelected = false;
  @override
  Widget build(ctx) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 34,width:102  ,
        child: ElevatedButton(
          onPressed: (){ setState(() {
            isSelected = !isSelected;
          });},
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor:  isSelected ? Color.fromARGB(255, 205, 205, 205) : Color(0xFFD9D9D9),
            shadowColor: Colors.transparent,
            overlayColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Row(
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon!.icon, size: 10, color: Color.fromARGB(255, 50, 47, 47)),
                SizedBox(width: 6),
              ],
              SizedBox(width: 5,),
              Text(
                widget.text,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: isSelected ? Colors.white : Colors.black,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
