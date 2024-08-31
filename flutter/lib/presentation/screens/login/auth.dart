import 'package:flutter/material.dart';

import 'components/cancel_button.dart';
import 'forms/login_form.dart';
import 'forms/register_form.dart';
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool isLogin = true;
  late Animation<double> containerSize;
  AnimationController? animationController;
  Duration animationDuration = const Duration(milliseconds: 270);

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
    double viewInset = MediaQuery.of(context).viewInsets.bottom;
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);

    containerSize =
        Tween<double>(begin: size.height * 0.1, end: defaultRegisterSize)
            .animate(CurvedAnimation(
            parent: animationController!, curve: Curves.linear));

    return Scaffold(
      body: Stack(
        children: [
          // Circle Elements
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

          // Cancel Button
          CancelButton(
            isLogin: isLogin,
            animationDuration: animationDuration,
            size: size,
            animationController: animationController,
            tapEvent: isLogin
                ? null
                : () {
              animationController!.reverse();
              setState(() {
                isLogin = !isLogin;
              });
            },
          ),

          // Login and Register Forms
          LoginForm(
            isLogin: isLogin,
            animationDuration: animationDuration,
            size: size,
            defaultLoginSize: defaultLoginSize,
          ),

          AnimatedBuilder(
            animation: animationController!,
            builder: (context, child) {
              if (viewInset == 0 && isLogin) {
                return buildRegisterContainer();
              } else if (!isLogin) {
                return buildRegisterContainer();
              }

              return Container();
            },
          ),

          RegisterForm(
            isLogin: isLogin,
            animationDuration: animationDuration,
            size: size,
            defaultLoginSize: defaultRegisterSize,
          ),

          // Back Button (placed last to be on top)
          Positioned(
            top: 20,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_circle_left_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
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
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(100),
            topRight: Radius.circular(100),
          ),
          color: const Color(0xff94aed7).withOpacity(1),
        ),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: !isLogin
              ? null
              : () {
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
                    color: Color(0xff253338),
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
