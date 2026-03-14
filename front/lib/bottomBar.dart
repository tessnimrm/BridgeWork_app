import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return Container(
      height: 70 + bottomPadding, // إضافة padding السفلي للارتفاع الكلي
      decoration: const BoxDecoration(color: Colors.white),
      padding: EdgeInsets.only(bottom: bottomPadding), // padding في الأسفل فقط
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(FontAwesomeIcons.house, "Home", 0),
          _buildNavItem(FontAwesomeIcons.commentDots, "Messages", 1),
          _buildNavItem(LineIcons.user, "Profile", 2),
          _buildNavItem(LineIcons.cog, "Settings", 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = currentIndex == index;
    bool isLargeIcon = icon == LineIcons.user || icon == LineIcons.cog;
    Color selectedColor = HexColor("#D9D9D9");
    Color unselectedColor = HexColor("#6B7280");

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          width: 130,
          height: 54,
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? HexColor("#6B7280") : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? selectedColor : unselectedColor,
                size: isLargeIcon ? 28 : 24,
              ),
              if (isSelected) ...[
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    color: selectedColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
