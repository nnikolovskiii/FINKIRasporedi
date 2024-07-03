import 'package:flutter/material.dart';

import '../login_components/rounded_button.dart';
import '../login_components/rounded_input.dart';
import '../login_components/rounded_password_input.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isLogin ? 1.0 : 0.0,
      duration: animationDuration * 4,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: size.width,
          height: defaultLoginSize,
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
                 SizedBox(height: 5),
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
                const RoundedPasswordInput(hint: 'Password',color: Colors.white, textColor: Color(0xff275085),),
                SizedBox(height: 10),
                RoundedButton(title: 'LOGIN', color:Colors.blue , textColor: Colors.white,),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
