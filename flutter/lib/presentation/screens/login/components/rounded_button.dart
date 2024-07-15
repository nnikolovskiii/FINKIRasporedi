import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final Color textColor;

  const RoundedButton({
    super.key,
    required this.title,
    required this.color,
    required this.textColor,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: size.width * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(color: textColor, fontSize: 18),
        ),
      ),
    );
  }
}
