import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../components/rounded_button.dart';
import '../components/rounded_input.dart';
import '../components/rounded_password_input.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
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
      opacity: isLogin ? 0.0 : 1.0,
      duration: animationDuration * 6,
      child: Visibility(
        visible: !isLogin,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: size.width,
            height: defaultLoginSize,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Text(
                    'Добредојде',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xff253338)
                    ),
                  ),
                  const SizedBox(height: 5),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double imageWidth = constraints.maxWidth < 600
                          ? constraints.maxWidth * 0.5 // For mobile
                          : constraints.maxWidth * 0.2; // For web
                      return SizedBox(
                        width: imageWidth,
                        child: Image.asset(
                          'resources/images/ideas.gif',
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                  const RoundedInput(icon: Icons.person , hint: 'Корисничко име',textColor: Color(0xff253338), color: Colors.white,),
                  const RoundedInput(icon: Icons.mail ,textColor: Color(0xff253338),hint: 'е-пошта',color: Colors.white,),
                  const RoundedPasswordInput(hint: 'Лозинка',color: Colors.white, textColor: Color(0xff253338),),
                  const RoundedPasswordInput(hint: 'Повтори лозинка',color: Colors.white, textColor: Color(0xff253338),),
                  const SizedBox(height: 10),
                  const RoundedButton(title: 'Регистрирај се', color:  Color(0xff253338), textColor: Colors.white,),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
