import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;

  CustomAppBar({required this.title, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: CustomShape(),
          size: Size(MediaQuery.of(context).size.width, preferredSize.height),
        ),
        Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          height: preferredSize.height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: title,
              ),
              Row(
                children: actions,
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120.0); // Adjust the height as needed
}

class CustomShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color =   Color(0xFF375f95).withOpacity(1);
    Path path = Path()
      ..lineTo(0, size.height - 40)
      ..quadraticBezierTo(
          size.width / 2, size.height, size.width, size.height - 40)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
