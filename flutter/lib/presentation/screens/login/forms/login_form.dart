import 'package:flutter/material.dart';

import '../components/rounded_button.dart';
import '../components/rounded_input.dart';
import '../components/rounded_password_input.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
  });

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 1.0 : 0.0,
      duration: widget.animationDuration * 4,
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: widget.size.width,
          height: widget.defaultLoginSize,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color(0xff253338)
                  ),
                ),
                const SizedBox(height: 5),
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Determine the image width based on the screen width
                    double imageWidth = constraints.maxWidth < 600
                        ? constraints.maxWidth * 0.5 // For mobile
                        : constraints.maxWidth * 0.2; // For web
                    return SizedBox(
                      width: imageWidth,
                      child: Image.asset(
                        'resources/images/Innovation.gif',
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
                const RoundedInput(icon: Icons.mail, hint: 'Username',color:  Color(0xff253338)  , textColor: Colors.white70,),
                const RoundedPasswordInput(hint: 'Password',color: Color(0xff253338), textColor: Colors.white70,),
                const SizedBox(height: 10),
                const RoundedButton(title: 'LOGIN', color:Color(0xFF608dc6) , textColor: Colors.white,),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
