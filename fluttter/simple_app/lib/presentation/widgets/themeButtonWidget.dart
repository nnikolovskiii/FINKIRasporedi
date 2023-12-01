import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ThemeButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;

  const ThemeButton({required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final double buttonSize = MediaQuery.of(context).size.width * 0.15;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8.0),
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}