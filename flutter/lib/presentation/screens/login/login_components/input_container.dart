import 'package:flutter/material.dart';


class InputContainer extends StatelessWidget {
  final Color color;

  const InputContainer({
    Key? key,
    required this.child, required this.color,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
           color: color,
        ),

        child: child
    );
  }
}