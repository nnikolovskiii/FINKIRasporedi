import 'package:flutter/material.dart';

import 'components/cancel_button.dart';
import 'forms/login_form.dart';
import 'forms/register_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  bool isLogin = true;
  late Animation<double> containerSize;
  AnimationController? animationController;
  Duration animationDuration = Duration(milliseconds: 270);

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: animationDuration);
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double viewInset = MediaQuery.of(context).viewInsets.bottom; // we are using this to determine Keyboard is opened or not
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);

    containerSize = Tween<double>(begin: size.height * 0.1, end: defaultRegisterSize)
        .animate(CurvedAnimation(parent: animationController!, curve: Curves.linear));

    return Scaffold(
      body: Stack(
        children: [
          // Let's add some decorations
          Positioned(
            top: 100,
            right: -50,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xFF375f95).withOpacity(1),
              ),
            ),
          ),
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xFF375f95).withOpacity(1),
              ),
            ),
          ),

          // Back Button
          Positioned(
            top: 20,
            left: 10,

            child: IconButton(
              icon: Icon(Icons.arrow_circle_left_rounded, color: Colors.white),
              iconSize: 40,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),

          // Cancel Button
          CancelButton(
            isLogin: isLogin,
            animationDuration: animationDuration,
            size: size,
            animationController: animationController,
            tapEvent: isLogin
                ? null
                : () { // returning null to disable the button
              animationController!.reverse();
              setState(() {
                isLogin = !isLogin;
              });
            },
          ),

          // Login Form
          LoginForm(
            isLogin: isLogin,
            animationDuration: animationDuration,
            size: size,
            defaultLoginSize: defaultLoginSize,
          ),

          // Register Container
          AnimatedBuilder(
            animation: animationController!,
            builder: (context, child) {
              if (viewInset == 0 && isLogin) {
                return buildRegisterContainer();
              } else if (!isLogin) {
                return buildRegisterContainer();
              }

              // Returning empty container to hide the widget
              return Container();
            },
          ),

          // Register Form
          RegisterForm(
            isLogin: isLogin,
            animationDuration: animationDuration,
            size: size,
            defaultLoginSize: defaultRegisterSize,
          ),
        ],
      ),
    );
  }

  Widget buildRegisterContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: containerSize.value,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
            topRight: Radius.circular(100),
          ),
          color: const Color(0xff94aed7).withOpacity(1),
        ),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: !isLogin ? null : () {
            animationController!.forward();
            setState(() {
              isLogin = !isLogin;
            });
          },
          child: isLogin
              ? const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Нов корисник? ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                TextSpan(
                  text: "Регистрирај се",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff253338), // Change this to your desired color
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          )
              : null,
        ),
      ),
    );
  }
}