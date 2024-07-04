import 'package:flutter/material.dart';

import 'input_container.dart';


class RoundedPasswordInput extends StatelessWidget {
  final Color color;
  final Color textColor;
  const RoundedPasswordInput({
    Key? key,
    required this.hint, required this.color, required this.textColor
  }) : super(key: key);

  final String hint;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
        color: color,
        child: TextField(
          cursorColor: Color(0XFF4b77b2),
          obscureText: true,
          style: TextStyle(color: textColor,  fontWeight: FontWeight.w400,),
          decoration: InputDecoration(
              icon: Icon(Icons.lock, color: textColor),
              hintText: hint,
              hintStyle: TextStyle(
                color: textColor, // Set hint text color to textColor
                fontWeight: FontWeight.w400, // Set font weight for hint text (use any other value if needed)
              ),
              border: InputBorder.none
          ),
        ));
  }
}