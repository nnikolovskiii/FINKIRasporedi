import 'package:flutter/material.dart';
import 'input_container.dart';

class RoundedInput extends StatelessWidget {
  final Color color;
  final Color textColor;

  const RoundedInput({
    super.key,
    required this.icon,
    required this.hint,
    required this.color,
    required this.textColor,
  });

  final IconData icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      color: color,
      child: TextField(
        cursorColor: Colors.white,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w400,
        ),
        // Text color
        decoration: InputDecoration(
          icon: Icon(icon, color: textColor),
          hintText: hint,
          hintStyle: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
