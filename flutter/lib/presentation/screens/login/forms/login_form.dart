import 'package:flutter/material.dart';
import '../../../../domain/models/login_request_model.dart';
import '../../../../service/auth_service.dart';
import '../../main_screen.dart';
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
  State<LoginForm> createState() => _LoginFormState();
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
    var screenSize = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent, // Set Material's color to transparent
      child: AnimatedOpacity(
        opacity: widget.isLogin ? 1.0 : 0.0,
        duration: widget.animationDuration * 4,
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: widget.size.width,
            height: widget.defaultLoginSize,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
              child: Form(
                key: globalFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Добредојде назад',
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
                      color: const Color(0xff253338),
                      textColor: Colors.white70,
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
                    RoundedPasswordInput(
                      hint: 'Лозинка',
                      color: const Color(0xff253338),
                      textColor: Colors.white70,
                      hidePassword: hidePassword,
                      togglePasswordVisibility: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ве молиме внесете ја вашата лозинка';
                        }
                        return null;
                      },
                    ),
                    if (error.isNotEmpty) _showErrorMessage(),
                    const SizedBox(height: 10),
                    RoundedButton(
                      title: 'Најави се',
                      color: const Color(0xFF608dc6),
                      textColor: Colors.white,
                      onPressed: () async {
                        if (globalFormKey.currentState!.validate()) {
                          globalFormKey.currentState!.save();

                          setState(() {
                            isApiCallProcess = true;
                          });

                          try {
                            dynamic result = await AuthService.login(
                              LoginRequestModel(
                                username: username,
                                password: password,
                              ),
                            );

                            setState(() {
                              isApiCallProcess = false;
                            });

                            if (result == true && context.mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const MainScreen(initialIndex: 0),
                                ),
                              );
                            } else {
                              setState(() {
                                error =
                                'Невалидно корисничко име или лозинка';
                              });
                            }
                          } catch (e) {
                            setState(() {
                              isApiCallProcess = false;
                              error = 'Неуспешно логирање: $e';
                            });
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showErrorMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        error,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
