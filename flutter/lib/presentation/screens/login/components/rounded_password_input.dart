import 'package:flutter/material.dart';

import 'input_container.dart';

class RoundedPasswordInput extends StatelessWidget {
  final Color color;
  final Color textColor;

  const RoundedPasswordInput(
      {super.key,
      required this.hint,
      required this.color,
      required this.textColor});

  final String hint;

  @override
  Widget build(BuildContext context) {
    return InputContainer(
        color: color,
        child: TextField(
          cursorColor: const Color(0XFF4b77b2),
          obscureText: true,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
              icon: Icon(Icons.lock, color: textColor),
              hintText: hint,
              hintStyle: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none),
        ));
  }
}
