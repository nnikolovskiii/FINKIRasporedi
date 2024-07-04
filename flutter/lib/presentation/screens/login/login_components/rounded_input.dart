import 'package:flutter/material.dart';
import 'input_container.dart';

class RoundedInput extends StatelessWidget {
  final Color color;
  final Color textColor;
  const RoundedInput({
    Key? key,
    required this.icon,
    required this.hint,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  final IconData icon;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      color: color,
      child: TextField(
        cursorColor: Colors.white,
        style: TextStyle(color: textColor,  fontWeight: FontWeight.w400,), // Text color
        decoration: InputDecoration(
          icon: Icon(icon, color: textColor),
          hintText: hint,
          hintStyle: TextStyle(
            color: textColor, // Set hint text color to textColor
            fontWeight: FontWeight.w400, // Set font weight for hint text (use any other value if needed)
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
