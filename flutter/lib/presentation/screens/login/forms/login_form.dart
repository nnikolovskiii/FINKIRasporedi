import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/login_request_model.dart';
import '../../../../domain/providers/schedule_provider.dart';
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

    return AnimatedOpacity(
      opacity: widget.isLogin ? 1.0 : 0.0,
      duration: widget.animationDuration * 4,
      child: Align(
        alignment: Alignment.center,
        child: Container(
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
// =======
//     return AnimatedOpacity(
//       opacity: widget.isLogin ? 1.0 : 0.0,
//       duration: widget.animationDuration * 4,
//       child: Align(
//         alignment: Alignment.center,
//         child: Container(
//           width: widget.size.width,
//           height: widget.defaultLoginSize,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Добредојде назад',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 24,
//                       color: Color(0xff253338)
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 LayoutBuilder(
//                   builder: (context, constraints) {
//                     // Determine the image width based on the screen width
//                     double imageWidth = constraints.maxWidth < 600
//                         ? constraints.maxWidth * 0.5 // For mobile
//                         : constraints.maxWidth * 0.2; // For web
//                     return SizedBox(
//                       width: imageWidth,
//                       child: Image.asset(
//                         'resources/images/Innovation.gif',
//                         fit: BoxFit.contain,
// >>>>>>> frontend
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
                          'resources/images/Innovation.gif',
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
                              error = 'Невалидно корисничко име или лозинка';
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
// =======
//                 const RoundedInput(icon: Icons.person, hint: 'Корисничко име',color:  Color(0xff253338)  , textColor: Colors.white70,),
//                 const RoundedPasswordInput(hint: 'Лозинка',color: Color(0xff253338), textColor: Colors.white70,),
//                 const SizedBox(height: 10),
//                 const RoundedButton(title: 'Најави се', color:Color(0xFF608dc6) , textColor: Colors.white,),
//                 SizedBox(height: 10),
//               ],
// >>>>>>> frontend
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