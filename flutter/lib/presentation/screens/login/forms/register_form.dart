import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import '../components/rounded_input.dart';
import '../components/rounded_password_input.dart';
import 'package:flutter_app/service/auth_service.dart';
import 'package:flutter_app/domain/models/register_request_model.dart';
import 'login_form.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
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
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 0.0 : 1.0,
      duration: widget.animationDuration * 6,
      child: Visibility(
        visible: !widget.isLogin,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: widget.size.width,
            height: widget.defaultLoginSize,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Добредојде',
                      style: TextStyle(

                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xff253338),
                      ),
                    ),
                    const SizedBox(height: 5),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double imageWidth = constraints.maxWidth < 600
                            ? constraints.maxWidth * 0.5
                            : constraints.maxWidth * 0.2;
                        return SizedBox(
                          width: imageWidth,
                          child: Image.asset(
                            'resources/images/ideas.gif',
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),
                    RoundedInput(
                      icon: Icons.person,
                      hint: 'Корисничко име',
                      color: Colors.white,
                      textColor: const Color(0xff253338),
                      onChanged: (val) {
                        setState(() => username = val);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ве молиме внесете го вашето корисничко име';
                        }
                        return null;
                      },
                    ),
                    RoundedInput(
                      icon: Icons.mail,
                      hint: 'е-пошта',
                      color: Colors.white,
                      textColor: const Color(0xff253338),
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ве молиме внесете ја вашата е-пошта';
                        }
                        return null;
                      },
                    ),
                    RoundedPasswordInput(
                      hint: 'Лозинка',
                      color: Colors.white,
                      textColor: const Color(0xff253338),
                      hidePassword: _obscurePassword,
                      togglePasswordVisibility: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ве молиме внесете ја вашата лозинка';
                        }
                        if (value.length < 5) {
                          return 'Лозинката мора да е барем 5 карактери';
                        }
                        return null;
                      },
                    ),
                    RoundedPasswordInput(
                      hint: 'Потврди лозинка',
                      color: Colors.white,
                      textColor: const Color(0xff253338),
                      hidePassword: _obscureConfirmPassword,
                      togglePasswordVisibility: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      onChanged: (val) {
                        setState(() => confirmPassword = val);
                      },
                      validator: (value) {
                        if (value != password) {
                          return 'Лозинките не се совпаѓаат';
                        }
                        return null;
                      },
                    ),
                    if (error.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          error,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    RoundedButton(
                      title: 'Регистрирај се',
                      color: const Color(0xff253338),
                      textColor: Colors.white,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _attemptSignUp();
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
// =======
//                       );
//                     },
//                   ),
//                   const RoundedInput(icon: Icons.person , hint: 'Корисничко име',textColor: Color(0xff253338), color: Colors.white,),
//                   const RoundedInput(icon: Icons.mail ,textColor: Color(0xff253338),hint: 'е-пошта',color: Colors.white,),
//                   const RoundedPasswordInput(hint: 'Лозинка',color: Colors.white, textColor: Color(0xff253338),),
//                   const RoundedPasswordInput(hint: 'Повтори лозинка',color: Colors.white, textColor: Color(0xff253338),),
//                   const SizedBox(height: 10),
//                   const RoundedButton(title: 'Регистрирај се', color:  Color(0xff253338), textColor: Colors.white,),
//                   const SizedBox(height: 10),
//                 ],
// >>>>>>> frontend
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _attemptSignUp() async {
    try {
      await AuthService.register(RegisterRequestModel(
        username: username,
        email: email,
        password: password,
      ));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginForm(
            isLogin: true,
            animationDuration: widget.animationDuration,
            size: widget.size,
            defaultLoginSize: widget.defaultLoginSize,
          ),
        ),
      );
    } catch (e) {
      setState(() {
        error = 'Регистрацијата е неуспешна: ${e.toString().split(': ').last}';
      });
    }
  }
}
