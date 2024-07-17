import 'package:flutter/material.dart';
import 'input_container.dart';

class RoundedInput extends StatelessWidget {
  final Color color;
  final Color textColor;
  final IconData icon;
  final String hint;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const RoundedInput({
    super.key,
    required this.icon,
    required this.hint,
    required this.color,
    required this.textColor,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      color: color,
      child: TextFormField(
        cursorColor: Colors.white,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          icon: Icon(icon, color: textColor),
          hintText: hint,
          hintStyle: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          errorStyle: const TextStyle(color: Colors.redAccent),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
