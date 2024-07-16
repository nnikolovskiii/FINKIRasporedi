import 'package:flutter/material.dart';
import 'input_container.dart';

class RoundedPasswordInput extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String hint;
  final bool hidePassword;
  final VoidCallback togglePasswordVisibility;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const RoundedPasswordInput({
    super.key,
    required this.hint,
    required this.color,
    required this.textColor,
    required this.hidePassword,
    required this.togglePasswordVisibility,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      color: color,
      child: TextFormField(
        cursorColor: const Color(0XFF4b77b2),
        obscureText: hidePassword,
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
          border: InputBorder.none,
          errorStyle: const TextStyle(color: Colors.redAccent),
          suffixIcon: IconButton(
            onPressed: togglePasswordVisibility,
            icon: Icon(
              hidePassword ? Icons.visibility_off : Icons.visibility,
              color: textColor,
            ),
          ),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
